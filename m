From: Sebastien.Hinderer@inria.fr (=?utf-8?Q?S=C3=A9bastien?= Hinderer)
Date: Tue, 8 Mar 2016 10:25:50 +0100
Subject: [Cocci] Parsing C source files by Coccinelle
In-Reply-To: <56DE9954.6080805@users.sourceforge.net>
References: <CAJTCqFadstafOZPgjDoV48zNFBHkTdp+4=a0WLGbfKaTCSqgOw@mail.gmail.com>
 <56D99C75.7080100@users.sourceforge.net>
 <CAO=9Y+2Qm+A9a91zGrYNJavOXcWFR2hj5Xx+=FPG1p02KdC7Ew@mail.gmail.com>
 <56DDCAD3.2080309@users.sourceforge.net>
 <20160308090014.GB1455@pl-59055.rocqadm.inria.fr>
 <56DE9954.6080805@users.sourceforge.net>
Message-ID: <20160308092550.GA1442@pl-59055.rocqadm.inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SF Markus Elfring (2016/03/08 10:20 +0100):
> Would the Coccinelle software benefit from the tool "Menhir" if it will
> take care for the parsing of C source files, too?

>From a performance point of view it is not sure there would be any gain.
But obviously it would make more sense to use only one parser generator
rather than two. However a bug in Menhir currently prevents its usage to
generate the C parser. Once that bug will be fixed then using Menhir to
generate the C parser will become an option.

S?bastien.
