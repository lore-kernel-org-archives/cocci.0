From: francois.armand.fa@gmail.com (=?UTF-8?Q?Fran=C3=A7ois_Armand?=)
Date: Tue, 31 Mar 2015 14:56:29 +0200
Subject: [Cocci] Patching nested if's?
Message-ID: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'd like to patch the third if of a code block that looks like:

if (MY_SUCCESS != ret) {
      if (MY_EPERM != ret &&  MY_ENOENT != ret) {
          if (t < MAXR) {
              foo();
              goto retry;
          } else {
              bar();
          }
      }
}

I'd like to get:


if (MY_SUCCESS != ret) {
      if (MY_EPERM != ret &&  MY_ENOENT != ret) {
          if (myfunc() == 0) {
              goto retry;
          } else {
              bar();
          }
      }
}

I've been able so far to replace the if (t <MAXR) but this
also replaces lines with it (expresion < constant) elsewhere.
Which is why I'd like to constrain the pacth to this 3 nested
ifs pattern.

Removing calls to foo() is easy, since I want to remove them all.

I came up with the following invalid attempt
@@
expression t;
constant M;
@@
 if (...)
    if (...)
    {
       if (
-       t < M
+          myfunc()
          )
          {
      ...
      } else {
      ...
      }
    }
  }

Thanks for any hint.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150331/092cd2c1/attachment.html>
