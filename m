From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 6 Jan 2013 07:21:21 +0100 (CET)
Subject: [Cocci] Parsing error for struct names starting with two
 underscore
In-Reply-To: <50E8ADCB.9090407@redhat.com>
References: <50E74F50.6000308@redhat.com>
 <alpine.DEB.2.02.1301050906120.2085@localhost6.localdomain6>
 <50E8ADCB.9090407@redhat.com>
Message-ID: <alpine.DEB.2.02.1301060721001.2070@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 5 Jan 2013, Michael Stefaniuc wrote:

> Thanks Julia,
>
> On 01/05/2013 09:07 AM, Julia Lawall wrote:
>> The problem is that it was considering anything beginning with __ that
>> is followed by an identifier to be an attribute.  The following patch
>> does not do that when the __ thing is immediately preceded by a struct.
>> Perhaps that is not the best solution, but it works in this case.
> the patch works here though only for structs and not unions. Which is
> good enough for Wine. One of this days I should learn OCaml so I can
> modify coccinelle myself...

Thanks.  I will adjust the case for unions as well.

julia
