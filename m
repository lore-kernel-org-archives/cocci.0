From: zied.habtoul@gmail.com (Zied Habtoul)
Date: Thu, 21 May 2015 12:19:27 +0200
Subject: [Cocci] array addressing range checking by coccinelle
Message-ID: <CABBGRWtAHM7naeENzeVQu_n0QC9EhCpUEvv_0MyZ+VH8zfxgxg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

hello,
i want to implement a script to check this rule
Before any array access, the addressing range must be checked.

example
in this code

void main ()
{

int T[10];
 T[20] = 5 ;

}


the script must detect an error on ( T[20] = 5 ;)  because there is an
overflow of the array size.

any suggestions please to implement this script ?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150521/f481d227/attachment.html>
