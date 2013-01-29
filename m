From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 29 Jan 2013 22:10:30 +0100
Subject: [Cocci] Dangling whitespace on added newlines
Message-ID: <51083AC6.1000606@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

when coccinelle automatically adds a newline after removing "{}" the
added newline has dangling whitespace corresponding to the indentation
level. Please see the attached test case and generated patch.

thanks
bye
	michael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dangling.c
Type: text/x-csrc
Size: 161 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130129/d52532f5/attachment.bin>
-------------- next part --------------
@@
identifier mem;
statement S;
@@
 mem = malloc(...);
 if (mem == NULL)
-{
-    ERR(...);
     S
-}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dangling.diff
Type: text/x-patch
Size: 236 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130129/d52532f5/attachment-0001.bin>
