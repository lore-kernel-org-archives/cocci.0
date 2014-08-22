From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 22 Aug 2014 23:28:54 +0200
Subject: [Cocci] Does coccinelle have the notion of signedness?
In-Reply-To: <1408739891.32045.43.camel@QNXWS8653-PC>
References: <1408739891.32045.43.camel@QNXWS8653-PC>
Message-ID: <CA+MoWDr8t3TF_rm5octP-KUT+OazG=HdfYxQNr4K-Ami4f+jEQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I would try:
@r@
type T;
identifier i;
@@
T i;

@script:python@
T << r.T;
@@
if "unsigned" not in T:
cocci.include_match(False)

@printer@
type r.T;
identifier r.i;
@@
* T i;

On Fri, Aug 22, 2014 at 10:38 PM, Mitchell Cuddie <mcuddie@qnx.com> wrote:
> Julia,
>
> I would like to declare a metatype T, where T is restricted to the set
> of unsigned types.
>
> (i.e. unsigned long, unsigned int, but not int or long)
>
> cheers,
>
> Mitchell
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Peter
