From: rminnich@gmail.com (ron minnich)
Date: Thu, 02 Apr 2015 16:33:46 +0000
Subject: [Cocci] Add code to functions that use a certain variable
Message-ID: <CAP6exYJacksEinpk_djJ5VYT85o0yBeqOQbZPWURadTrQKTzhA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have this typedef in Plan 9
typedef struct Mach Mach;

a global
Mach *m;

and functions:
a(...){
...
m->whatever = x;
...
}

I want to add some code after the {
+Mach *m=machp();

I.e. for any function that uses the "global" (it's not really that, it's a
bit more complex) I want to add a local variable that is initialized.

My efforts so far have failed badly.

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150402/231fbe2c/attachment.html>
