# 0415
import MySQLdb
from flask import url_for,jsonify,redirect,render_template,Flask, request
import random
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
                        #    port = 3307,
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
    elif wrong[0] == 2:
        results = """
        <p>輸入不能為空</p>
        <p><a href="/register">返回註冊介面</a></p>
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

# 登出帳號
@app.route('/logout', methods=['GET', 'POST'])
def logout():
    global logged_in_user_id
    logged_in_user_id = None
    return redirect(url_for('index'))
# 建立帳號
def insert_user(student_id, password, grade, d_id):
    # 建立連接
    conn = sql_log()
    #all the input can't be empty,if empty return false
    if student_id == "" or password == "" or grade == "" or d_id == "":
        wrong[0] = 2
        return False
    # 欲新增的 query 指令
    query = "INSERT INTO student (student_id, student_password, grade, department_id) VALUES ('{}', '{}', '{}', '{}');".format(
        student_id, password, grade, d_id)
    # 執行新增，並且尋找如果有相同的名字就不新增，並且跳到錯誤頁面
    # 要先執行查詢，再執行新增，不然會有問題
    cursor = conn.cursor()
    cursor.execute("SELECT student_id FROM student WHERE student_id = '{}';".format(student_id))
    result = cursor.fetchone()
    if result is None:
        # 如果查詢結果為 None，則表示資料庫中沒有該名稱，可以新增
        cursor.execute(query)
        conn.commit()
        # 新增該學系的必修課程到 SelectedCourse
        cursor.execute("SELECT course_id FROM Course WHERE department_id = %s AND required = 1 AND grade = %s ", (d_id, grade))
        All_Need_to_courses = cursor.fetchall()
        
        for course in All_Need_to_courses:
            insert_course_query = "INSERT INTO SelectedCourse (course_id, student_id) VALUES (%s, %s)"
            cursor.execute(insert_course_query, (course[0], student_id))
            conn.commit()
            # 更新課表人數
            update_query = "UPDATE Course SET curNumOfSelect = curNumOfSelect + 1 WHERE course_id = %s"
            cursor.execute(update_query, (course[0],))
            conn.commit()

        return True
    else:
        # 如果查詢結果不為 None，則表示資料庫中已存在該名稱，不應新增
        wrong[0] = 0
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
    global logged_in_user_id
    if logged_in_user_id:
        return render_template('CourseSelection.html', logged_in_user_id=logged_in_user_id)
    else:
        return redirect(url_for('login'))

# 課程退選
@app.route('/course_deselection', methods=['GET', 'POST']) 
def course_deselection():
    return render_template('withdrawPage.html')

# 取得所有已選課程
@app.route('/get_selected_courses', methods=['POST'])
def get_selected_courses():
    # 聲明全局變量
    global logged_in_user_id
    # 建立資料庫連接
    conn = sql_log()
    # 建立 cursor 物件 - 字典
    cursor = conn.cursor(MySQLdb.cursors.DictCursor)
    try:
        # 運用 SQL 語法查詢該系所的 id
        cursor.execute("SELECT * FROM selectedcourse WHERE student_id = %s;", (logged_in_user_id,))
        studentID_result = cursor.fetchone()
        # 有無找到相關資訊
        if studentID_result:
            cursor.execute("SELECT * FROM Course WHERE course_id IN(SELECT course_id FROM selectedcourse WHERE student_id = %s);", (logged_in_user_id,))
            courses = cursor.fetchall()
            return jsonify(courses)
        else:
            error_msg = {"error": "Course not found"}
            return jsonify(error_msg), 404
    finally:
        # 關閉 cursor 和資料庫連接
        cursor.close()
        conn.close()

# 退選課程
@app.route('/withdraw_courses', methods=['POST'])
def withdraw_courses():
    # 聲明全局變量
    global logged_in_user_id
    # 建立資料庫連接
    conn = sql_log()
    # 獲取前端傳遞的課程ID
    course_id = request.form.get('course_id')
    # 建立 cursor 物件 - 字典
    cursor = conn.cursor(MySQLdb.cursors.DictCursor)

    # 檢查退選後是否會低於9學分
    cursor.execute("SELECT credit FROM Course WHERE course_id = %s;", (course_id,))
    numOfCredits = cursor.fetchone()['credit']
    if will_credit_Under_limit(logged_in_user_id, numOfCredits):
        # 如果退選後學分低於9，則向前端返回錯誤訊息
        return jsonify({"error": "無法低於9學分!請選擇其他課程。"}), 400

    try:
        # 檢查課程是否存在並且屬於當前用戶
        cursor.execute("SELECT * FROM selectedcourse WHERE course_id = %s AND student_id = %s;", (course_id, logged_in_user_id,))
        course = cursor.fetchone()
        if course:
            # 檢查是否為必修課程
            cursor.execute("SELECT required FROM Course WHERE course_id = %s;", (course_id,))
            required = cursor.fetchone()['required']
            if required == 1:
                # 如果是必修課程，將提示訊息傳送到前端並等待用戶的確認
                return jsonify({"message": "這是一門必修課程，確定要退選嗎？", "confirm_required": True})
            else:
                # 如果不是必修課程，直接執行退選操作
                # 刪除課程
                cursor.execute("DELETE FROM selectedcourse WHERE course_id = %s AND student_id = %s;", (course_id, logged_in_user_id,))
                cursor.execute("UPDATE Course set curNumOfSelect  = curNumOfSelect - 1 where  course_id = %s;", (course_id,))
                conn.commit()  # 提交事務
                
                # 檢查等待名單是否有學生在等待這門課
                cursor.execute("SELECT student_id FROM Waitlist WHERE course_id = %s;", (course_id,))
                waitlist = cursor.fetchall()
                waitlist = tuple(record['student_id'] for record in waitlist)
                if len(waitlist) > 0:
                    # 從等待名單中選擇一個學生並將他們添加到已選課程中
                    selected_student = random.choice(waitlist)
                    cursor.execute("DELETE FROM Waitlist WHERE course_id = %s AND student_id = %s;", (course_id, selected_student))
                    cursor.execute("INSERT INTO selectedcourse (course_id, student_id) VALUES (%s, %s);", (course_id, selected_student))
                    cursor.execute("UPDATE Course set curNumOfSelect  = curNumOfSelect + 1 where  course_id = %s;", (course_id,))
                    conn.commit()
                return jsonify({"message": "Course withdrawn successfully."})
        else:
            return jsonify({"error": "Course not found or not selected by the current user."}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # 錯誤處理
    finally:
        # 關閉 cursor 和資料庫連接
        cursor.close()
        conn.close()

@app.route('/withdraw_courses_without_check', methods=['POST'])
def withdraw_courses_without_check():
    # 聲明全局變量
    global logged_in_user_id
    # 建立資料庫連接
    conn = sql_log()
    # 獲取前端傳遞的課程ID
    course_id = request.form.get('course_id')
    # 建立 cursor 物件 - 字典
    cursor = conn.cursor(MySQLdb.cursors.DictCursor)
    try:
        # 檢查課程是否存在並且屬於當前用戶
        cursor.execute("SELECT * FROM selectedcourse WHERE course_id = %s AND student_id = %s;", (course_id, logged_in_user_id,))
        course = cursor.fetchone()
        if course:
            cursor.execute("DELETE FROM selectedcourse WHERE course_id = %s AND student_id = %s;", (course_id, logged_in_user_id,))
            cursor.execute("UPDATE Course set curNumOfSelect  = curNumOfSelect - 1 where  course_id = %s;", (course_id,))
            conn.commit()  # 提交事務
            # 檢查等待名單是否有學生在等待這門課
            cursor.execute("SELECT student_id FROM Waitlist WHERE course_id = %s;", (course_id,))
            waitlist = cursor.fetchall()
            waitlist = tuple(record['student_id'] for record in waitlist)
            if len(waitlist) > 0:
                # 從等待名單中選擇一個學生並將他們添加到已選課程中
                selected_student = random.choice(waitlist)
                cursor.execute("DELETE FROM Waitlist WHERE course_id = %s AND student_id = %s;", (course_id, selected_student))
                cursor.execute("INSERT INTO selectedcourse (course_id, student_id) VALUES (%s, %s);", (course_id, selected_student))
                cursor.execute("UPDATE Course set curNumOfSelect  = curNumOfSelect + 1 where  course_id = %s;", (course_id,))
                conn.commit()
            return jsonify({"message": "Course withdrawn successfully."})
        else:
            return jsonify({"error": "Course not found or not selected by the current user."}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # 錯誤處理
    finally:
        # 關閉 cursor 和資料庫連接
        cursor.close()
        conn.close()


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

        # 對每門課程進行處理，獲取該課程的上課時間
        for course in courses:
            course_id = course['course_id']
            # 從 CourseTime 表中查詢該課程的上課時間
            cursor.execute("SELECT week_day, time_index FROM CourseTime WHERE course_id = %s", (course_id,))
            course_times = cursor.fetchall()
            # 將查詢到的上課時間資料加入到課程的字典中
            course['course_times'] = course_times
            print(course)

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
        return jsonify({"success": False, "error": "Course already added"})
    elif not is_student_of_department(course_id, logged_in_user_id):
        # 如果學生不是該系所的學生
        print("Not a student of the department")
        return jsonify({"success": False, "error": "Not a student of the department"})
    elif not is_course_time_conflict(course_id, logged_in_user_id):
        # 如果課程時間有衝突
        print("Course time conflict")
        return jsonify({"success": False, "error": "Course time conflict"})
    elif is_selected_course_have_same(course_id, logged_in_user_id):
        # 如果課程有相同名稱的被選擇
        print("Course is have the same")
        return jsonify({"success": False, "error": "Course is have the same"})
    elif is_credit_Over_limit(logged_in_user_id, course_id):
        # 如果學分超過上限
        print("Credit is over the limit")
        return jsonify({"success": False, "error": "Credit is over the limit (30)"})
    elif not is_qualify(course_id, logged_in_user_id):
        # 如果不符合課程擋修限制
        print("You don't qualify the course blocking restrictions")
        return jsonify({"success": False, "error": "You don't qualify the course blocking restrictions"})
    elif is_course_of_capacity(course_id):
        # 如果課程人數已滿
        print("Course is full,add to waitlist")
        # insert into waitlist
        insert_query = "INSERT INTO Waitlist (course_id, student_id) VALUES (%s, %s)"
        cursor = conn.cursor()
        cursor.execute(insert_query, (course_id, logged_in_user_id))
        conn.commit()
        return jsonify({"success": False, "error": "Course is full,add to waitlist"})
    else:
        # 插入課程ID和學生ID
        try:
            insert_query = "INSERT INTO SelectedCourse (course_id, student_id) VALUES (%s, %s)"
            cursor = conn.cursor()
            cursor.execute(insert_query, (course_id, logged_in_user_id))
            conn.commit()
            # 更新課表中的CurNumOfSelect
            update_query = "UPDATE Course SET curNumOfSelect = curNumOfSelect + 1 WHERE course_id = %s"
            cursor.execute(update_query, (course_id,))
            conn.commit()
            # 確定人數
            select_query = "SELECT maxNumOfSelect, curNumOfSelect FROM Course WHERE course_id = %s"
            cursor.execute(select_query, (course_id,))
            cur_num = cursor.fetchone()  # 只需要一次fetchone()
            maxNumOfSelect = cur_num[0]
            curNumOfSelect = cur_num[1]
            # 需要將數字轉為字符才能連接字串
            print("success Now have" + ":" + str(curNumOfSelect) + "/" + str(maxNumOfSelect))
            success_response = {"success": True, "message": "Now have: " + str(curNumOfSelect) + "/" + str(maxNumOfSelect)}
        except Exception as e:
            conn.rollback()
            success_response = {"success": False, "error": str(e)}
        return jsonify(success_response)

# 確保符合課程擋修限制的function
def is_qualify(course_id, student_id):
    # 建立資料庫連接
    conn = sql_log()
    cursor = conn.cursor()

    try:
        # 從 Course 表中獲取目標課程的主題
        cursor.execute("SELECT course_name FROM Course WHERE course_id = %s", (course_id,))
        course_name = cursor.fetchone()[0]

        # 檢查是否有未修過的先修課程
        cursor.execute("""
            SELECT RequiredCourse
            FROM PrerequisiteCourses
            WHERE MainSubject = %s
            AND RequiredCourse NOT IN (
                SELECT course_name
                FROM HistoryTable
                WHERE student_id = %s
            )
        """, (course_name, student_id))

        missing_courses = cursor.fetchall()

        if len(missing_courses) == 0:
            print("該學生已經修過所有需要的先修課程。")
            return True
        else:
            print("以下先修課程尚未修過：")
            for course in missing_courses:
                print(course[0])
                return False

    except Exception as e:
        print("查詢失敗:", str(e))

    finally:
        # 關閉 cursor 和資料庫連接
        cursor.close()
        conn.close()


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

# 確保該課程的人數未滿
def is_course_of_capacity(course_id):
    query = "SELECT * FROM Course WHERE course_id = %s AND maxNumOfSelect <= CurNumOfSelect"
    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query, (course_id,))
    result = cursor.fetchone()
    # 如果查詢結果為 None，則表示該課程的人數已滿
    return result is not None

# 確保沒有衝堂的課程
def is_course_time_conflict(course_id, student_id):
    # 該名同學已選擇的課程
    # SELECT ct1.week_day, ct1.time_index FROM CourseTime ct1 WHERE ct1.course_id = "001"
    # AND EXISTS (SELECT 1 FROM CourseTime ct2 INNER JOIN SelectedCourse sc ON ct2.course_id = sc.course_id
    #     WHERE sc.student_id = "D1234567" AND ct2.week_day = ct1.week_day AND ct2.time_index = ct1.time_index)
    query = """SELECT ct1.week_day, ct1.time_index FROM CourseTime ct1 WHERE ct1.course_id = %s 
    AND EXISTS (SELECT 1 FROM CourseTime ct2 INNER JOIN SelectedCourse sc ON ct2.course_id = sc.course_id WHERE sc.student_id = %s 
    AND ct2.week_day = ct1.week_day AND ct2.time_index = ct1.time_index)"""

    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query, (course_id, student_id))
    result = cursor.fetchone()
    # 如果查詢結果為 not None，則表示該課程的時間與已選擇的課程時間有衝突
    return result is None

# 確保沒有相同名稱的課程
def is_selected_course_have_same(course_id, student_id):
    query = """SELECT c.course_name
    FROM SelectedCourse sc
    JOIN Course c ON sc.course_id = c.course_id
    WHERE sc.student_id = %s AND c.course_name in (SELECT course_name FROM Course WHERE course_id = %s)"""
    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query, (student_id, course_id))
    result = cursor.fetchone()
    # 如果查詢結果為 None，則表示該課程已經被選擇
    return result is not None

# 確保學分沒有超過上限
def is_credit_Over_limit(student_id, course_id):
    query = """SELECT SUM(c.credit) FROM SelectedCourse sc JOIN Course c on sc.course_id =  c.course_id WHERE sc.student_id = %s"""
    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query,(student_id,))
    result = cursor.fetchone()
    print(result)
    # 確定這次的學分加上 總學分 < 30
    now_query = """SELECT credit FROM Course WHERE course_id = %s"""
    cursor.execute(now_query,(course_id,))
    now_result = cursor.fetchone()

    if result[0] is not None :
        total_credit = int(result[0])
        now_credit = int(now_result[0])
        return (total_credit + now_credit) > 30
    else :
        return False
    
# 確保學分沒有低於下限
def will_credit_Under_limit(student_id, credits):
    query = """SELECT SUM(c.credit) FROM SelectedCourse sc JOIN Course c on sc.course_id =  c.course_id WHERE sc.student_id = %s"""
    conn = sql_log()
    cursor = conn.cursor()
    cursor.execute(query,(student_id,))
    result = cursor.fetchone()
    print(result)
    if result[0] is not None :
        total_credit = int(result[0])
        return total_credit - credits < 9
    else :
        return False

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


# 尋找課程評分
@app.route('/rate', methods=['GET', 'POST'])
def rate():
    if request.method == 'POST':
        course_id = request.form.get('course_id')

        conn = sql_log()
        c = conn.cursor()

        # 查詢 Course 表
        c.execute("SELECT * FROM Course WHERE course_id=%s", (course_id,))
        course = c.fetchone()

        # 查詢 COURSE_RATE 表
        c.execute("SELECT * FROM COURSE_RATE WHERE course_id=%s", (course_id,))
        course_rate = c.fetchone()

        conn.close()

        if course and course_rate:
            course_name = course[1]
            rate = course_rate[1] / course_rate[3] if course_rate[3] != 0 else 0
            comments = course_rate[2].split('::')
            comments = comments[1:]
            return render_template('check_rate.html', course_name=course_name, rate=rate, comments=comments)

        return render_template('check_rate.html', course_name=None)

    return render_template('check_rate.html', course_name=None)
# 查看選課紀錄
@app.route('/history', methods=['GET', 'POST'])
def history():
    global logged_in_user_id
    conn = sql_log()
    c = conn.cursor()
    # 查詢 SelectedCourse 表
    c.execute("SELECT * FROM historytable WHERE student_id=%s", (logged_in_user_id,))
    selected_courses = c.fetchall()
    # 查詢 Course 表
    courses = []
    for selected_course in selected_courses:
        courses.append(selected_course)
    conn.close()
    return render_template('history.html', courses=courses)
# 進行評分
@app.route('/to_rate/<string:course_id>', methods=['GET', 'POST'])
def to_rate(course_id):
    if request.method == 'POST':
        rate = int(request.form.get('rate'))
        print(rate)
        comment = request.form.get('comment')
        conn = sql_log()
        c = conn.cursor()
        print(course_id)
        # 更新 COURSE_RATE 表
        c.execute("UPDATE COURSE_RATE SET rate = rate + %s, comment=CONCAT(comment, '::', %s), comment_total=comment_total+1 WHERE course_id=%s",
        (rate, comment, course_id))
        conn.commit()
        conn.close()
        return redirect(url_for('course_selection'))
    return render_template('to_rate.html', course_id=course_id)
#進階搜尋
@app.route('/searchmore', methods=['GET', 'POST'])
def searchmore():
    if request.method == 'POST':
        conn = sql_log()
        c = conn.cursor()
        # 從表單中獲取選擇的時間和年級
        selected_times = request.form.getlist('time')
        selected_grades = request.form.getlist('grade')

        # 在這裡，你可以將這些數據存儲到 SQL 資料庫中，進行進一步的處理
        # 這裡僅是示例，假設你已經有了一個名為 db 的資料庫連接對象
        # 你可以使用適合的方式將數據存儲到資料庫中
        for time in selected_times:
            # 假設有一個名為 times 的資料表，包含 id 和 time 兩個欄位
            c.execute("INSERT INTO times (time) VALUES (?)", (time,))
        
        for grade in selected_grades:
            # 假設有一個名為 grades 的資料表，包含 id 和 grade 兩個欄位
            c.execute("INSERT INTO grades (grade) VALUES (?)", (grade,))
        
        # 提交資料庫操作
        c.commit()

        # 在此處可以進行其他處理，例如重新導向到其他頁面
        return '表單已提交'
@app.route('/get_courses2', methods=['POST'])
def get_courses2():
    # 從course的表單獲取選擇的系所 id
    selected_department_name = request.form['course']
    if request.form['time']:
        selected_time = request.form['time']
    else:
        selected_time = 'time_index'
    if request.form['week']:
        selected_week = request.form['week']
    else:
        selected_week = 'week_day'
    if request.form['credit']:
        selected_credit = request.form['credit']
    else:
        selected_credit = 'credit'
    department_id = int(selected_department_name) + 1
    # 測試是否獲取到系所 id
    print("Selected department2 name:", department_id)
    print(selected_time + "\n" + selected_week + "\n" + selected_credit)  
    conn = sql_log()
    # 建立 cursor 物件 - 字典
    cursor = conn.cursor(MySQLdb.cursors.DictCursor)
    # 運用 SQL 語法查詢該系所的 id
    cursor.execute("SELECT Course.department_id FROM Course JOIN CourseTime ON Course.course_id = CourseTime.course_id WHERE Course.department_id = %s AND CourseTime.week_day = %s AND Course.credit = %s AND CourseTime.time_index = %s;", (department_id,selected_week,selected_credit,selected_time,))
    dept_result = cursor.fetchone()  
    # 有無找到相關資訊
    if dept_result:
        dept_id = dept_result['department_id'] 
        cursor.execute("SELECT * FROM Course JOIN CourseTime ON Course.course_id = CourseTime.course_id WHERE Course.department_id = %s AND CourseTime.week_day = %s AND Course.credit = %s AND CourseTime.time_index = %s;", (dept_id,selected_week,selected_credit,selected_time,))
        courses = cursor.fetchall()

        # 對每門課程進行處理，獲取該課程的上課時間
        for course in courses:
            course_id = course['course_id']
            # 從 CourseTime 表中查詢該課程的上課時間
            cursor.execute("SELECT week_day, time_index FROM CourseTime WHERE course_id = %s", (course_id,))
            course_times = cursor.fetchall()
            # 將查詢到的上課時間資料加入到課程的字典中
            course['course_times'] = course_times
            print(course)

        return jsonify(courses)
    else:
        error_msg = {"error": "Course not found"}
        return jsonify(error_msg), 404
    