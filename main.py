#!/usr/bin/env python3
# coding=utf-8
# -*- coding: UTF-8 -*-
from flask import Flask, request
import MySQLdb
from flask import render_template
from flask import redirect
from flask import url_for

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
                           passwd="123",
                           db='courseselectionsystem')
    return conn

# 初始畫面
@app.route('/')
def index():
    return render_template('index.html')

# 註冊帳號
@app.route('/register', methods=['GET', 'POST'])
def register():
    mylist = ["資訊工程學系","電機工程學系","電子工程學系","自動控制工程學系","資訊電機學院學士班","通訊工程學系","光電科學與工程學系","通識中心","應用數學學系","統計學系"]

    if request.method == 'POST':
        id[0] += 1
        username = request.form.get('username')
        department = request.form.get('department')
        # 在這裡處理註冊邏輯
        if insert_user(id[0],username, department):
            return redirect(url_for('index'))
        else:
            return redirect(url_for('error'))
    return render_template('register.html', class_list = mylist)

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
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        # 在這裡處理登入邏輯
        if check_user(username, password):
            return redirect(url_for('index'))
        else:
            wrong[0] = 1
            return redirect(url_for('error'))
    return render_template('login.html')
def insert_user(id,username, department):
    # 建立連接
    conn = sql_log()
    userid = id
    name = username
    depart = department
    # 欲新增的 query 指令
    query = "INSERT INTO user (user_id,user_name, department) VALUES ('{}', '{}', '{}');".format(
    userid, name, depart)
    # 執行新增，並且尋找如果有相同的名字就不新增，並且跳到錯誤頁面
    # 要先執行查詢，再執行新增，不然會有問題
    cursor = conn.cursor()
    cursor.execute(query)
    conn.commit()
    return True
    
# 查詢使用者
def check_user(username, password):
    # 建立連接
    conn = sql_log()
    name = username
    passwd = password
    # 欲查詢的 query 指令
    query = "SELECT name FROM user_acc WHERE name = '{}' AND passwd = '{}';".format(
        name, passwd)
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
    
    
    