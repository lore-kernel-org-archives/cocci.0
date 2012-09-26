From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Wed, 26 Sep 2012 16:36:56 +0200
Subject: [Cocci] Help with SMPL
Message-ID: <CA+MoWDrEmG1NowmRpB3S_4MnnxOk1q9=fo-tkCmL3PLrgn5K0w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dear List,

I'm trying to make a semantic patch for the case described on the patch:
http://www.mail-archive.com/linux-media at vger.kernel.org/msg52660.html

Some relevant code snippets:

http://lxr.free-electrons.com/source/drivers/media/video/em28xx/em28xx.h#L482
-- // --
struct em28xx {
...
int model;              /* index in the device_data struct */
...
struct em28xx_board board;
...
}
-- // --

http://lxr.free-electrons.com/source/drivers/media/video/em28xx/em28xx.h#L690
-- // --
...
extern struct em28xx_board em28xx_boards[];
...
-- // --

I'm trying the semantic patch:
@@
type T;
expression to,from,flag;
@@
- memcpy((T)&to,(T)&from,flag);
+ to = from;

But it is not working. How can I specify "to" and "from" for match
cases like this?

Thanks,

Peter
-- 
Peter
