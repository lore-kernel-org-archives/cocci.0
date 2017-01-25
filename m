From: rjones@redhat.com (Richard W.M. Jones)
Date: Wed, 25 Jan 2017 10:14:21 +0000
Subject: [Cocci] Selecting Python 3 at configure time
Message-ID: <20170125101421.GA9653@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


This bug was filed against the Fedora package:
https://bugzilla.redhat.com/show_bug.cgi?id=1416323

I looked at configure.ac and the Makefiles, but I cannot work out how
you tell ./configure to use /usr/bin/python3 instead of
/usr/bin/python, if indeed that is possible at all - it's not clear
that it is.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
