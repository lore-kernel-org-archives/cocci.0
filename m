From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 8 Mar 2016 10:00:14 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DDCAD3.2080309@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
Message-ID: <20160308090014.GB1455@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

SF Markus Elfring (2016/03/07 19:39 +0100):
> > I am interested in exploring how Coccinelle is parsing C programs,
> 
> The software library "http://cristal.inria.fr/~fpottier/menhir/"
> is involved to some degree.

No, not for parsing C. Currently, Menhir (an advanced alternative to
ocamlyacc) is used only to generate the SmPL parser, not the C parser.

S?bastien.
