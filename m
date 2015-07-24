From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 24 Jul 2015 19:21:56 +0200
Subject: [Cocci] sys.path for Python?
In-Reply-To: <CA+MoWDoKWWOpuUj=YoYWgVT73rOKhrcJPWCt_f-ro085D1T9cw@mail.gmail.com>
References: <CA+MoWDoKWWOpuUj=YoYWgVT73rOKhrcJPWCt_f-ro085D1T9cw@mail.gmail.com>
Message-ID: <55B27434.40303@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> sys.path.append("/home/peter/devel/git/the-conference/devel/featureccinelle/cocci-files/")
> from Common import *

Do you prefer to store such a string in your SmPL script
as a temporary workaround?

How do you think about to make the directory name configurable
by a corresponding variable?
Should other shell scripts control and adjust the desired source code
analysis eventually?

Regards,
Markus
