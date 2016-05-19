From: wendy.liang@xilinx.com (Jiaying Liang)
Date: Thu, 19 May 2016 20:41:17 +0000
Subject: [Cocci] How to add a field to c structure definition
Message-ID: <DC2968D6352D1841BA729D8C06CC9DBB796FD9AB@XSJ-PSEXMBX01.xlnx.xilinx.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am looking for a way to add a field to a c structure definition.

I have this:

struct struct_A {
   int a;
   int b;
};

struct struct_B {
  int c;
  int d;
};

I want to change "struct struct_A" to:
struct struct_A {
  int a;
  int b;
  struct struct_B;
};

Thanks,
Wendy


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160519/cf4f8980/attachment.html>
