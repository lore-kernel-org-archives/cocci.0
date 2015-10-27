From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 27 Oct 2015 13:37:48 +0100
Subject: [Cocci] version 1.0.3 released
In-Reply-To: <20151027115733.GB14273@redhat.com>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
Message-ID: <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi again Richard and all,

Richard W.M. Jones (2015/10/27 11:57 +0000):
> BTW the 'spgen' program is installed, but it's broken.  It's built as
> a bytecode program using 'ocamlc -custom', RPM strips it (removing the
> bytecode), and consequently the binary won't function on Fedora.  It
> should have been built as a native program since I requested 'make
> world'.

A new release of coccinelle fixing this issue will be published soon
(hopefully tomorrow).

S?bastien.
