From: devel.fx.lebail@orange.fr (Francois-Xavier Le Bail)
Date: Thu, 8 Feb 2018 16:15:50 +0100
Subject: [Cocci] Not pointer expression
In-Reply-To: <alpine.DEB.2.20.1802081539391.23604@hadrien>
References: <f33cbd82-389c-77c4-65f9-af15f4eb4ab3@orange.fr>
 <alpine.DEB.2.20.1802081539391.23604@hadrien>
Message-ID: <8d635d32-fecb-db89-4d01-e6be446d7be0@orange.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/02/2018 15:44, Julia Lawall wrote:
> 
> 
> On Thu, 8 Feb 2018, Francois-Xavier Le Bail wrote:
> 
>> Hi,
>>
>> expression *e;
>> define 'e' is a pointer expression.
>>
>> Is there a way to define 'e' is *not* a pointer expression?
> 
> @@
> expression *e;
> expression e1;
> @@
> 
> (
> e
> |
> *e1
> )
> 
> The above will highlight all expressions that have not been inferred to
> have a pointer type.  But note that that doesn't mean that it has been
> inferred that the expression as a non-pointer type.  It could be that not
> enough information is available.
> 
> Another option would be:
> 
> @@
> expression *e;
> type T;
> T e1;
> @@
> 
> (
> e
> |
> *e1
> )
> 
> Now it should require that e1 actually has a known type and it is not a
> pointer type.
> 
> Another approach would be:
> 
> @bad@
> position p;
> expression *e;
> @@
> 
> e at p
> 
> @ok@
> position p != bad.p;
> type T;
> T e;
> @@
> 
> *e at p
> 
> If you are actually interested in structure types, you could also say
> 
> struct e;

Thanks, I will do some tests with these different approaches.

-- 
Francois-Xavier
