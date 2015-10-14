From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 14 Oct 2015 22:59:13 +0200
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <20151014085350.GB1543@pl-59055.rocqadm.inria.fr>
References: <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
 <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
 <20151014071143.GA6178@pema>
 <alpine.DEB.2.10.1510140956240.2421@hadrien>
 <20151014085350.GB1543@pl-59055.rocqadm.inria.fr>
Message-ID: <20151014205913.GH14464@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 14, 2015 at 10:53:50AM +0200, S?bastien Hinderer wrote:
> Hi,
> 
> Luis: here is what I am guessing.
> 
> At some point in the past you have installed OCaml and then compiled
> Menhir from sources with that version of OCaml. Meanwhile the OCaml
> related packages got updated but Menhir has not been recompiled with
> the updated version of OCaml, hence the inconsistency.
> 
> My suggestion would thus be to make sure you recompile Menhir with the
> currently installed version of OCaml.

S?bastien,

your guess was correct. I also tested using a new base OpenSUSE factory
install for both github and inria git repos for coccinelle and found
that:

  * github: works as expected
  * inria git: required menhir but fails with a compilation failure [0]

Then with only the latest and greatest on inira git:

  * menhir: compiled
  * coccinelle: compiles

Once I forced recompilation of menhir things worked well. The
reason things seem to work on debian is menhir is packaged and
updated regularly, and I suppose it might be updated as ocaml
gets updated as otherwise Debian would run into similar issues,
and if not I suspect they will once ocaml on Debian does get
upgraded :)

I wonder how we'll avoid these dependency issues creeping up moving
forward. This is pretty fragile, and if the git tree will represent
later the latest and greatest what should we do about mehir
dependencies?

For your convenience I've taken the time to document getting you
an opensuse chroot you can play with on Debian [1] but sadly
Debian zypper package currently has an odd issue [2]. So alternatively
you can just use docker [3] to get an opensuse factory thing going.
Both these options are the equivalent of using debootstrap on OpenSUSE.

Long term I realize you had some plans for possibly jenkins, otherwise
another option is the opensuse build service, which lets you get things
built over different distributions. I'm afraid that such solutions
might not pick up these sorts of issues though, I don't think they
upgrade the system but rather have a fresh install for each shoot,
not sure... BTW if you go the docker way and want to reproduce my
issues for bullet proof bug you could end up first compiling menhir
with the default docker image ocaml, then 'zypper dup' to upgrade
ocaml version and finally compiling  coccinelle.

Thanks for your help!

[0] Perhaps this should be prettier and require menhir then.

/usr/bin/ocamldep -I ../commons -I ../commons/ocamlextra -I ../globals *.mli *.ml > .depend
make[3]: Leaving directory '/root/coccinelle/ctl'
make[3]: Entering directory '/root/coccinelle/parsing_cocci'
/root/coccinelle/setup/fake-menhir.sh menhir --ocamlc "/usr/bin/ocamlc.opt" --ocamldep "/usr/bin/ocamldep" --table --base parser_cocci_menhir parser_cocci_menhir.mly
error: the file parser_cocci_menhir.ml is needed, which requires preprocessing by menhir to obtain it from parser_cocci_menhir.mly. However, menhir is not enabled.
make[3]: *** No rule to make target 'parser_cocci_menhir.ml', needed by 'depend'.  Stop.

[1] If zypper on Debian actually worked...

rm -rf /opt/opensuse/

mkdir -p /opt/opensuse/dev/
mknod /opt/opensuse/dev/zero c 1 5 

zypper --root /data/opensuse/ ar http://download.opensuse.org/factory/repo/oss repo-oss
zypper --gpg-auto-import-keys -n --root /data/opensuse install rpm zypper wget vim

[2] zypper sucks on Debian right now

root at garbanzo:~# zypper
zypper: relocation error: zypper: symbol _ZN4zypp5CpeId11NoThrowType13lastMalformedE, version ZYPP_plain not defined in file libzypp.so.1503 with link time reference

[3] Use docker to get the latest and greatest OpenSUSE factory

apt-get install docker
docker pull opensuse

# on one terminal
docker daemon

# to copy files or folders (say coccinelle git or menhir tarball)
# you'll want to run from your host machine, after using
# docker ps to get the image ID
docker cp ~/some-path/coccinelle/ docker-image-id:/root/

# then get a terminal going
docker run -t -i opensuse /bin/bash

# upgrade the machine (avoid this if you want to try to repdroduce
# the theoretical issue iwth menhir and ocaml, and instead first
# compile and install menhir
zypper --gpg-auto-import-keys -n dup

# ca-certificates-mozilla will be needed for git clone over https on
# github
zypper --gpg-auto-import-keys -n install git ca-certificates-mozilla

# silly thing, opensuse doens't have this enable by default so one cannot
# use zypper si -d (source-intall) to get build dependencies by default...
# sucks!
zypper ar -f http://download.opensuse.org/factory/repo/src-oss repo-src-oss
zypper --gpg-auto-import-keys -n si -d coccinelle

# missing dependencies - I'll go report these. I've cc'd the maintainer
# but I'll also just take the liberty to submit the changes into osc [4].
# I'll note the build gets odd issues if you do not have tar. So a possible
# enhancement to autotools on coccinelle might be to require tar.
zypper --gpg-auto-import-keys -n install autoconf automake make tar

# To build the other goodies:

# get PCRE
zypper --gpg-auto-import-keys -n install pcre-tools pcre-devel

# Documentation
zypper --gpg-auto-import-keys -n install texlive-latex-bin-bin

Note I cannot still build the documentation, so I have given up
even with the above installed.

[4] Contributing to opensuse for the coccinelle package:

First get osc installed

But really first get an account on open build service:

https://build.opensuse.org/

You'll use that for osc.

git clone https://github.com/openSUSE/osc.git
cd osc

# you'll need these little buggers
sudo apt-get install python-urlgrabber python-gnomekeyring
python setup.py build
sudo python setup.py install
sudo ln -sf /home/mcgrof/devel/osc/osc-wrapper.py /usr/bin/osc

Then to get coccinelle package a la apt-get source coccinelle,
but with mechanisms so you can contribute directly as if you
are using svn:

mkdir -p ~/devel/
cd ~/devel/
osc co openSUSE:Factory/coccinelle
cd openSUSE\:Factory/coccinelle/
vi coccinelle.spec

osc diff

But to contribute you need your own branch, etc, see the documentation
for more details:

https://en.opensuse.org/openSUSE:How_to_contribute_to_Factory
 
  Luis
