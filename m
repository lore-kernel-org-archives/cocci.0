From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 29 Nov 2013 13:41:16 +0100
Subject: [Cocci] version missmatch
In-Reply-To: <alpine.DEB.2.10.1311291202080.2088@hadrien>
References: <20131129102538.GA11900@opentech.at>
 <alpine.DEB.2.10.1311291202080.2088@hadrien>
Message-ID: <20131129124116.GA31818@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 29 Nov 2013, Julia Lawall wrote:

> On Fri, 29 Nov 2013, Nicholas Mc Guire wrote:
> 
> >
> > Hi !
> >
> >  minor glitch in the rc18 release (or should it be rc17 ?)
> >  after downloading coccinelle-1.0.0-rc18.tgz unpacking and
> >  compile/installing it on Debian wheezy it shows up as rc17
> >
> > root at Xil:~# tar -xzf coccinelle-1.0.0-rc18.tgz
> > root at Xil:~# cd coccinelle-1.0.0-rc18/
> > root at Xil:~/coccinelle-1.0.0-rc18# ./configure --with-python --with-menhir
> > root at Xil:~/coccinelle-1.0.0-rc18# make all
> > root at Xil:~/coccinelle-1.0.0-rc18# make install
> > root at Xil:~/coccinelle-1.0.0-rc18# export PATH=/usr/local/bin:$PATH
> > root at Xil:~/coccinelle-1.0.0-rc18# patch --version
> > root at Xilinx:/usr/src/janitor/tools/coccinelle-1.0.0-rc18# /usr/local/bin/spatch --version
> > spatch version 1.0.0-rc17 without Python support and with Str regexp support roo
> >
> >  since I never had rc17 installed I guess something went wrong with packaging ?
> >
> >  also not sure why it says without python - it reported no errors config or
> >  build ?
> >  a make coccicheck in the kernel then complains about
> >  ..
> >  Fatal error: exception Failure("no python")
> >
> >  any idea what is wrong with the install procedure ? (python2.6-dev and
> >  python3.1-dev as well as menhir is installed)
> 
> Unfortunately, I understand almost nothing about the build system :(
>

well if a Debian specific requirements/download/compile/install/running
instruction would be usefull for the manual to fill in chapter 2 let me know
 
> I will try to be sure that for the next release the name that Coccinelle
> is given matches the name that it actually is...
> 
> For python, I'm not sure.  Where is python located on your machine?  I see
> some mentions of python2.7 instead of python2.6.  Maybe you need that
> version?
>
python 2.6 seems fine - the problem was that it depends on pkg-config and 
for python2.6 there was no package config file in /usr/lib/pkgconfig/ - bute 
force solution isntall python 3.1 (which comes with a valid .pc file) 
copy python-3.1.pc to python-2.6.pc and fix it up manually (its only a 
few lines) then rebuild coccinelle with 
./configure  --with-python --enable-python --enable-pycaml

 and that gives me

root at Xil:~/tools/coccinelle-1.0.0-rc18# spatch --version
spatch version 1.0.0-rc17 with Python support and with Str regexp support root at X

since make coccicheck works again in the kernel I guess its fine.

thx!
hofrat 
