From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 May 2013 12:23:27 +0200 (CEST)
Subject: [Cocci] python variable in spatch
In-Reply-To: <CAKGFgN1wM+9-ALpJ4QO1Y5_pjhXJdZWBBEgWesdsq64v+_1jpg@mail.gmail.com>
References: <CAKGFgN1wM+9-ALpJ4QO1Y5_pjhXJdZWBBEgWesdsq64v+_1jpg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1305291222330.2246@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 29 May 2013, Anthony wrote:

> Hi,
>
> I would like to apply a semantic patch which will include some values
> generated through a @script:python@ block, but I didn't succeed so
> far.
> e.g.: update variable names based on a csv file, parsed in a python block.
> Any idea someone ?

Did you take a look at demos/pythontococci.cocci ?

If that didn't help, please send an example that causes problems.

julia
