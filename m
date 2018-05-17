From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 17 May 2018 22:31:52 +0200 (CEST)
Subject: [Cocci] [bug] exists do not work if file group is too big (>49)
In-Reply-To: <alpine.DEB.2.20.1805172219490.2273@hadrien>
References: <20180516191634.GB2994@redhat.com>
 <alpine.DEB.2.20.1805172219490.2273@hadrien>
Message-ID: <alpine.DEB.2.20.1805172227090.2273@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Concretely, the problem is with LOCK_REQ, which is used as a typedef name
in cifs and as a enum constant in f2fs.

Would there be any chance of getting rid of the LOCK_REQ typedef?
Typedefs for structure types are discouraged by the Linux kernel coding
style.

julia
