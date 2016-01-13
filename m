From: rjones@redhat.com (Richard W.M. Jones)
Date: Wed, 13 Jan 2016 15:01:33 +0000
Subject: [Cocci] Build failure on ppc64le: Failure("dump: impossible tag
 (1002)")
In-Reply-To: <5696652C.5080903@users.sourceforge.net>
References: <20160113134818.GA30557@redhat.com>
 <alpine.DEB.2.10.1601131516180.5214@hadrien>
 <20160113142332.GM1766@redhat.com>
 <5696652C.5080903@users.sourceforge.net>
Message-ID: <20160113150133.GO1766@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 13, 2016 at 03:54:36PM +0100, SF Markus Elfring wrote:
> > But note I'm not saying this is not a compiler bug.
> > We've had a few.
> 
> Interesting ?
> 
> How do you think about to share any more information
> about the last working system configuration
> for your special build environment?

I'm not sure that it has ever worked on ppc64le.  Looking at our POWER
build systems status:

http://ppc.koji.fedoraproject.org/koji/packageinfo?packageID=919

it looks like it has not built successfully for 3 years, and the last
time it was building that was only on ppc32.

> > Is there a test case you could send me?
> 
> In which kind of test scripts are you interested in?

Anything that would narrow down or potentially reproduce this
particular error, I guess.  Basically if you need me to run any
diagnostic tests, I can.

We also (in partnership with IBM) have a public rack of POWER systems
that anyone can provision (but you have to agree to some legal stuff):

http://research.redhat.com/powerlinux-openpower-development-hosting/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
