import MySQLdb
from flask import url_for,jsonify,redirect,render_template,Flask, request
from sqlite3 import IntegrityError

# 存放登入成功id
logged_in_user_id = None

wrong = [0]
id = [0]
app = Flask(__name__)

if __name__ == '__main__':
    app.run(debug = True,host = "0.0.0.0",port = 5000)

# 連接資料庫
def sql_log():
    # 建立資料庫連線
    conn = MySQLdb.connect(host="127.0.0.1",
                           user="DBAdmin",
                           #WU
                           port = 3307,
                           passwd="123",
                           db="CourseSelectionSystem",)
    return conn

# 初始畫面
@app.route('/')
def index():
    return render_template('index.html')

# 重複帳號需要跳錯誤訊息，重新導向(未完成)
# 註冊帳號
@app.route('/register', methods=['GET', 'POST'])
def register():
    mylist = ["資訊工程學系","電機工程學系","電子工程學系","自動控制工程學系","資訊電機學院學士班","通訊工程學系","光電科學與工程學系","通識中心","應用數學學系","統計學系"]

    if request.method == 'POST':
        id[0] += 1
        student_id = request.form.get('student_id')
        password = request.form.get('password')  # 取得密碼
        grade = request.form.get('grade')  # 取得年級
        department = request.form.get('department')
        d_id = 0

        for index, depart in enumerate(mylist):
            if depart == department :
                d_id = index + 1
        
        # 在這裡處理註冊邏輯
        if insert_user(student_id, password, grade, d_id):
            return redirect(url_for('index'))
        else:
            return redirect(url_for('error'))
    return render_template('register.html', class_list=mylist)


# 查詢介面
@app.route('/action', methods=['POST'])
def action():
    # 取得輸入的文字
    my_head = request.form.get("my_head")
    conn = sql_log()
    # 欲查詢的 query 指令
    query = "SELECT description FROM people where name LIKE '{}%';".format(
        my_head)
    # 執行查詢
    cursor = conn.cursor()
    cursor.execute(query)

    results = """
    <p><a href="/">Back to Query Interface</a></p>
    """
    # 取得並列出所有查詢結果
    for (description, ) in cursor.fetchall():
        results += "<p>{}</p>".format(description)
    return results

# 錯誤頁面
@app.route('/error', methods=['GET','POST'])
def error():
    if wrong[0] == 0:
        results = """
        <p>此帳號已被註冊過</p>
        <p><a href="/register">返回查詢介面</a></p>
        """
    elif wrong[0] == 1:
        results = """
        <p>帳號或密碼錯誤</p>
        <p><a href="/login">返回登入介面</a></p>
        """
    return results

# 登入帳號
@app.route('/login', methods=['GET', 'POST'])
def login():
    global logged_in_user_id
    if request.method == 'POST':
        student_id = request.form.get('student_id')
        password = request.form.get('password')
        # 在這裡處理登入邏輯
        # 成功跳到course_selection的畫面
        if check_user(student_id, password):
            # 將學生 ID 存入全局變數
            logged_in_user_id = student_id
            print("logged_in_user_id:", logged_in_user_id)
            return redirect(url_for('course_selection'))
        else:
            wrong[0] = 1
            return redirect(url_for('error'))
    return render_template('login.html')

def insert_user(username, password):
    # 建立連接
    conn = sql_log('userdb')
    name = username
    passwd = password
    # 欲新增的 query 指令
    query = "INSERT INTO user_acc (name, passwd) VALUES ('{}', '{}');".format(
        name, passwd)
    # 執行新增，並且尋找如果有相同的名字就不新增，並且跳到錯誤頁面
    # 要先執行查詢，再執行新增，不然會有問題
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM user_acc WHERE name = '{}';".format(name))
    result = cursor.fetchone()
    if result is None:
        # 如果查詢結果為 None，則表示資料庫中沒有該名稱，可以新增
        cursor.execute(query)
        conn.commit()
        return True
    else:
        # 如果查詢結果不為 None，則表示資料庫中已存在該名稱，不應新增
        return False
    
# 查詢使用者
def check_user(student_id, password):
    # 建立連接
    conn = sql_log()
    # 欲查詢的 query 指令
    query = "SELECT student_id FROM Student WHERE student_id = '{}' AND student_password = '{}';".format(
        student_id, password)
    # 執行查詢
    cursor = conn.cursor()
    cursor.execute(query)
    result = cursor.fetchone()
    if result is None:
        # 如果查詢結果為 None，則表示資料庫中沒有該名稱，不可以登入
        return False
    else:
        # 如果查詢結果不為 None，則表示資料庫中已存在該名稱，可以登入
        return True
    
# 課程選擇
@app.route('/course_selection', methods=['GET', 'POST']) 
def course_selection():
    return render_template('CourseSelection.html')

# 顯示該系所的課程
@app.route('/get_courses', methods=['POST'])
def get_courses():
    # 從course的表單獲取選擇的系所 id
    selected_department_name = request.form['course']
    department_id = int(selected_department_name) + 1

    # 測試是否獲取到系所 id
    print("Selected department name:", department_id)  
    conn = sql_log()
    # 建立 cursor 物件 - 字典
    cursor = conn.cursor(MySQLdb.cursors.DictCursor)
    # 運用 SQL 語法查詢該系所的 id
    cursor.execute("SELECT department_id FROM Course WHERE department_id = %s;", (department_id,))
    dept_result = cursor.fetchone()  
    # 有無找到相關資訊
    if dept_result:
        dept_id = dept_result['department_id'] 
        cursor.execute("SELECT * FROM Course WHERE department_id = %s;", (dept_id,))
        courses = cursor.fetchall()
        return jsonify(courses)
    else:
        error_msg = {"error": "Course not found"}
        return jsonify(error_msg), 404
    
# 加入課程 
# todo: 避免不符合條件的課程
@app.route('/add_course', methods=['POST'])
def add_course():
    # 聲明全局變量
    global logged_in_user_id
    # 獲取前端傳遞的課程ID
    course_id = request.form.get('course_id')
    # 測試是否獲取到課程ID
    print("course_id:", course_id)
    # 將課程ID插入到SelectedCouse表中
    conn = sql_log()
    # 確保沒有重複的課程
    if course_already_added(course_id, logged_in_user_id):
        # 如果課程已經被選擇過在自己的課表內
        print("Course already added")
        return jsonify({"success": False, "error": "Course already added"});
    elif not is_student_of_department(course_id, logged_in_user_id):
        # 如果學生不是該系所的學生
        print("Not a student of the department")
        return jsonify({"success": False, "error": "Not a student of the department"});
    else:
        # 插入課程ID和學生ID
        try:
            query = "INSERT INTO SelectedCourse (course_id, student_id) VALUES (%s, %s)"
            cursor = conn.cursor()
            cursor.execute(query, (course_id, logged_in_user_id))
            conn.commit()
            print("success")
            success_response = {"success": True}
        except IntegrityError as e:
            conn.rollback()
            success_response = {"success": False, "error": "Course already added"}
        except Exception as e:
            conn.rollback()
            success_response = {"success": False, "error": str(e)}
        return jsonify(success_response)

# 確保沒有選到重複課程的function
def course_already_added(course_id, student_id):
    query = "SELECT * FROM SelectedCourse WHERE course_id = %s AND student_id = %s"
    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query, (course_id, student_id))
    result = cursor.fetchone()
    return result is not None

# 確保同學為該系所的學生
def is_student_of_department(course_id, student_id):
    query = "SELECT * FROM Student AS s WHERE s.department_id = (SELECT c.department_id FROM Course AS c WHERE c.course_id = %s) AND s.student_id = %s"
    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query, (course_id, student_id))
    result = cursor.fetchone()
    # 如果查詢結果為 None，則表示該學生不是該系所的學生
    return result is not None

# 抓取已選課程
def get_schedule_data():
    global logged_in_user_id
    conn = sql_log()
    # 查詢課表的語法
    query = ("SELECT sc.course_id, ct.week_day, ct.time_index ,c.course_name FROM selectedcourse sc "
             "INNER JOIN CourseTime ct ON sc.course_id = ct.course_id "
             "INNER JOIN course c ON c.course_id = sc.course_id "
             "WHERE sc.student_id = %s")  
    cursor = conn.cursor()
    cursor.execute(query, (logged_in_user_id,))
    schedule_data = cursor.fetchall()
    # 可以確定 schedule_data 是否為空
    print(schedule_data)

    return schedule_data

# 更新課表按鈕按下
@app.route('/update_schedule', methods=['GET'])
def update_schedule():
    schedule_data = get_schedule_data()  # 此函數可以從數據庫中獲取課表數據
    return jsonify(schedule_data)