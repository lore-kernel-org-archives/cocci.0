From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 25 Oct 2012 13:19:14 +0200 (CEST)
Subject: [Cocci] spatches for cpp?
In-Reply-To: <CAP6exYJCAAPUyc4K8dYfLG23Aekb1nEC=O4Cv-R2AL4TEEtABw@mail.gmail.com>
References: <CAP6exYJCAAPUyc4K8dYfLG23Aekb1nEC=O4Cv-R2AL4TEEtABw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1210251318530.1955@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 24 Oct 2012, ron minnich wrote:

> Are there ways to patch sequences such as
> #if x
> #endif
>
> to some other sequence? My tries have failed, I'm hoping I'm missing something.

No, it is not possible.  It is not possible to match on cpp code, only t
generate it.

julia
