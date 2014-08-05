From: akos.pasztory@gmail.com (Akos PASZTORY)
Date: Tue, 5 Aug 2014 13:40:15 +0300
Subject: [Cocci] unreadable files
Message-ID: <CAJwHcF62DVbQq9DUWzqwh8p6m8DuHK1x=Rtn3SBs2YAo1pFauQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently if coccinelle meets a file that it cannot open (e.g. it's an
dangling symlink), it exits with:
Fatal error: exception Sys_error("/tmp/aa/what.c: No such file or directory")
even if run in recursive mode (i.e. passing a directory as argument).

Could you please add a command line option to just skip those files
and keep running?  (like make -k)
