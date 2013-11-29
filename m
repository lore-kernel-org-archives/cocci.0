From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 29 Nov 2013 11:25:38 +0100
Subject: [Cocci] version missmatch
Message-ID: <20131129102538.GA11900@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi !

 minor glitch in the rc18 release (or should it be rc17 ?)
 after downloading coccinelle-1.0.0-rc18.tgz unpacking and
 compile/installing it on Debian wheezy it shows up as rc17

root at Xil:~# tar -xzf coccinelle-1.0.0-rc18.tgz  
root at Xil:~# cd coccinelle-1.0.0-rc18/
root at Xil:~/coccinelle-1.0.0-rc18# ./configure --with-python --with-menhir
root at Xil:~/coccinelle-1.0.0-rc18# make all
root at Xil:~/coccinelle-1.0.0-rc18# make install
root at Xil:~/coccinelle-1.0.0-rc18# export PATH=/usr/local/bin:$PATH
root at Xil:~/coccinelle-1.0.0-rc18# patch --version
root at Xilinx:/usr/src/janitor/tools/coccinelle-1.0.0-rc18# /usr/local/bin/spatch --version
spatch version 1.0.0-rc17 without Python support and with Str regexp support roo
 
 since I never had rc17 installed I guess something went wrong with packaging ?

 also not sure why it says without python - it reported no errors config or 
 build ? 
 a make coccicheck in the kernel then complains about
 ..
 Fatal error: exception Failure("no python")

 any idea what is wrong with the install procedure ? (python2.6-dev and 
 python3.1-dev as well as menhir is installed)


thx!
hofrat
