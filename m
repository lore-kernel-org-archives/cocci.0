From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 23 Oct 2014 12:59:56 -0700
Subject: [Cocci] git tag for counting uses of Coccinelle
Message-ID: <CAB=NE6Wst7qmtUrF6aM_z+dzOO+9Dmjyxrbtpw0croEjYXsvTQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In order to help be able to easily count uses of Coccinelle for kernel
development I'd like to propose the use of the tag:

Generated-by: Coccinelle SmPL

This would save space on commits where it seems more than the above
number of words are used to describe this exact thing.

  Luis
