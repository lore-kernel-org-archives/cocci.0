From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 29 Nov 2013 13:36:43 +0100 (CET)
Subject: [Cocci] version missmatch
In-Reply-To: <529889AB.5000304@redhat.com>
References: <20131129102538.GA11900@opentech.at>
 <CANrVCd1UyZdJWxPc1Oahw6hNH=YL9ipLKfw39z1xXiiuiXBgHg@mail.gmail.com>
 <529889AB.5000304@redhat.com>
Message-ID: <alpine.DEB.2.10.1311291336230.2088@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 29 Nov 2013, Michael Stefaniuc wrote:

> On 11/29/2013 01:07 PM, Arie Middelkoop wrote:
> > What is written in the "version" file in your coccinelle dir?
> > The tarball on the coccinelle website does have version rc18, so if you
> > have that one, it cannot have invented rc17 out of thin air...
> spatch --version returns that and it looks like it even misses a \n
>
> sibiu:~$ spatch --version
> spatch version 1.0.0-rc17 with Python support and with PCRE supportsibiu:~$
>
> sibiu:~$ rpm -q coccinelle
> coccinelle-1.0.0-0.rc18.1.fc19.x86_64
>
> This is a common problem that spatch --version is not correct; I had
> reported it this year too, afair in summer.

Yes, I remember...

julia


>
> bye
> 	michael
>
> >
> > Also, check the output of configure and also configure.log and scan for
> > lines about python, as this gives an indication what it found.
> >
> > Also, Debian "jessie" has rc18 together with python 2.6.
> >
> > Arie
> >
> >
> > 2013/11/29 Nicholas Mc Guire <der.herr at hofr.at <mailto:der.herr@hofr.at>>
> >
> >
> >     Hi !
> >
> >      minor glitch in the rc18 release (or should it be rc17 ?)
> >      after downloading coccinelle-1.0.0-rc18.tgz unpacking and
> >      compile/installing it on Debian wheezy it shows up as rc17
> >
> >     root at Xil:~# tar -xzf coccinelle-1.0.0-rc18.tgz
> >     root at Xil:~# cd coccinelle-1.0.0-rc18/
> >     root at Xil:~/coccinelle-1.0.0-rc18# ./configure --with-python
> >     --with-menhir
> >     root at Xil:~/coccinelle-1.0.0-rc18# make all
> >     root at Xil:~/coccinelle-1.0.0-rc18# make install
> >     root at Xil:~/coccinelle-1.0.0-rc18# export PATH=/usr/local/bin:$PATH
> >     root at Xil:~/coccinelle-1.0.0-rc18# patch --version
> >     root at Xilinx:/usr/src/janitor/tools/coccinelle-1.0.0-rc18#
> >     /usr/local/bin/spatch --version
> >     spatch version 1.0.0-rc17 without Python support and with Str regexp
> >     support roo
> >
> >      since I never had rc17 installed I guess something went wrong with
> >     packaging ?
> >
> >      also not sure why it says without python - it reported no errors
> >     config or
> >      build ?
> >      a make coccicheck in the kernel then complains about
> >      ..
> >      Fatal error: exception Failure("no python")
> >
> >      any idea what is wrong with the install procedure ? (python2.6-dev and
> >      python3.1-dev as well as menhir is installed)
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
