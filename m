From: mstefani@redhat.com (Michael Stefaniuc)
Date: Sun, 03 May 2015 23:14:50 +0200
Subject: [Cocci] smpl-spacing Whitespace Issue on Assignments (regression)
Message-ID: <55468FCA.5000402@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello Julia,

sorry for the delay, here is the whitespace regression though it affects
only --smpl-spacing

foo.cocci:
@@
expression e1, e2;
@@
- e1 = e2
+ c = d

foo.c:
void foo(void)
{
    int a, b;
    b = a;
}

spatch --smpl-spacing foo.cocci foo.c
gives:
-    b = a;
+    c=d;


bye
	michael
