From: rminnich@gmail.com (ron minnich)
Date: Thu, 02 Apr 2015 21:10:15 +0000
Subject: [Cocci] Add code to functions that use a certain variable
In-Reply-To: <alpine.DEB.2.02.1504022027020.2053@localhost6.localdomain6>
References: <CAP6exYJacksEinpk_djJ5VYT85o0yBeqOQbZPWURadTrQKTzhA@mail.gmail.com>
 <alpine.DEB.2.02.1504022027020.2053@localhost6.localdomain6>
Message-ID: <CAP6exY+fr3Kt5z1eREebmSVH2mYXDQQozfmgTW9g8uC5Pj_nYg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Here are two that work and one that fails, hopefully it will make more
sense.
poperror is a macro that uses m, so I know we need it there.

@@
function f;
@@
f(...){
+Mach *m = machp();
...
poperror();
}

Or I can add it to everything :-)
@@
function f;
@@
f(...){
+Mach *m = machp();
...
}

Here is one I can not get to work:
@@
typedef Mach;
Mach *m;
function f;
identifier x;
statement s;
@@
f(...){
+ Mach *m = machp();
...
x = m
...
}

The x = m could also be m->x, or if (m) s, and so on

thanks again

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150402/31a16442/attachment.html>
