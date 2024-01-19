<html>
    <style>
        *{
            margin:0;
            padding: 0;
        }
        .main{
            background: #F0F0F0;
        }
        .wrapper{
            padding: 20px;
            width: 600px;
            margin: auto;
            border-top: 20px solid #FE7A00;
            background: #fff;
            border-bottom: 20px solid #FE7A00;
        }
        .main-top{
            padding: 0;
            text-align: center;
            padding-bottom: 10px;
            margin-bottom: 15px;
            border-bottom: 1px solid #ccc;
        }
    </style>
    <div class="main">
        <div class="wrapper">
            <div class="main-top">
                <a href="https://expert.a-boss.ru/"><img src="cid:logo.png"></a>
            </div>
            <div class="content">
                {$HTML_MAIL_SEND}
            </div>
        </div>
    </div>
</html>



