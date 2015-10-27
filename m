From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 27 Oct 2015 10:38:39 +0100
Subject: [Cocci] version 1.0.3 released
In-Reply-To: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
Message-ID: <20151027093839.GA1503@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Julia Lawall (2015/10/26 22:12 +0100):
> * The dependency on ocamlp4 is removed, except when support for python is 
> included.

Read camlp4 rather than ocamlp4.
To be more precise, Coccinelle relies on a library called pycaml to
support Python scripts. camlp4 is required only to compile this library.
So if the library has been installed independently, e.g. through the
distribution's packaging system (as can be done on Debian since pycaml
is packaed), then camlp4 is not required. If the library has not been
installed and Python scripting support is requested, then Coccinelle's
build systemwill attempt to compile the bundled version of the camlp4
library, which will require camlp4.

S?bastien.
