From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Jan 2014 22:25:12 +0100 (CET)
Subject: [Cocci] [PATCH] Support for systems without [gs]etitimer API
In-Reply-To: <20140102203645.GA26767@localhost.localdomain>
References: <20140102203645.GA26767@localhost.localdomain>
Message-ID: <alpine.DEB.2.02.1401022224580.2024@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2 Jan 2014, Eugeniy Meshcheryakov wrote:

> Hi,
> 
> After enabling the testsuite execution when building Debian packages I
> noticed that the testsuite fails on Debian/Hurd. Every testcase was
> failing with Unix_error exception, because while Hurd has getitimer
> function, it just returns ENOSYS error there.
> 
> The attached patch detects whether the system has working getitimer
> function, and if not, makes coccinelle use alarm() API instead.
> 
> With this patch coccinelle builds fine on all Debian architectures with
> 386 successful test cases (expected: 377).

Applied.  Thanks!

julia
