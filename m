From: moustafa@cmpsamurai.com (Moustafa Mahmoud)
Date: Tue, 28 Aug 2018 09:36:33 +0200
Subject: [Cocci] =?utf-8?q?Embedding_Meta-variables_in_added_Comments_usin?=
	=?utf-8?q?g_semantic_patches=D8=B2?=
Message-ID: <CAKCTf_bKa6MbcvLw=0r+pjXB-TrqAKAPyXhu+vZ=0vXih7i54Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

this semantic patch doesn't produce the required behavioir

@annotate_if_conditions@
expression ex;
@@

<+...
+ /* ex */
if(ex){...}
...+>


it produces the following

     int x =5;
     int y =6;
     int m =funct();
+    /* ex */   // the required behavoir I need is  /* x */
     if(x)
     {
+       /* ex */
        if(y)
        {
            return 1;

Regards,
Moustafa
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180828/47bf471a/attachment.html>
