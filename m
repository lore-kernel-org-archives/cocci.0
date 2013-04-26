From: rjones@redhat.com (Richard W.M. Jones)
Date: Fri, 26 Apr 2013 09:14:34 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <5144D0F8.3040302@users.sourceforge.net>
References: <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
 <alpine.DEB.2.02.1303041645030.1984@hadrien>
 <5134C654.3050706@users.sourceforge.net>
 <CANrVCd3SaNhoMzaLFYsrkB6gX7vz9Nxb5L85be48pFNZ03Q6CA@mail.gmail.com>
 <5138B81B.2040100@users.sourceforge.net>
 <CANrVCd3HS+i84W01R-pZv5B1jz_r9HJVjJfVh1OxN1mGMmxAuA@mail.gmail.com>
 <5138C95F.8010608@users.sourceforge.net>
 <5144D0F8.3040302@users.sourceforge.net>
Message-ID: <20130426081434.GA3645@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, Mar 16, 2013 at 09:07:20PM +0100, SF Markus Elfring wrote:
> > I have got the impression that there are more update candidates to consider
> > since the macro call "AM_INIT_AUTOMAKE" was added.
> 
> Are you going to update and complete any components from your build
> specification and corresponding configuration scripts?

[Since you asked me in private email to contribute to
this discussion ...]

I think you're being unreasonable asking the Coccinelle developers to
fix things, and hardly specifying what the problem is (from what I can
gather it's something to do with separated builds not working?).

In any case, supply patches, with clear explanations behind each one.

So far I see one patch, probably incomplete, and no clear explanation
for it.

http://people.redhat.com/rjones/how-to-supply-code-to-open-source-projects/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
