From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 17:19:42 -0500
Subject: [Cocci] Search/replace inside string constants?
Message-ID: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Is there a way to edit string constants?  I need to change

"NVRM: ...."

into

"..."

That is, I need to remove the "NVRM: " from a string.  I tried this:

@depends on rule1@
@@
-"NVRM: "
+""

But it doesn't do anything.
