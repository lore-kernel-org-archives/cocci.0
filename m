From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Apr 2017 18:45:18 +0200 (CEST)
Subject: [Cocci] Q: question on disjunction of sub-expression patterns
In-Reply-To: <20170422160202.GA23532@redhat.com>
References: <20170422160202.GA23532@redhat.com>
Message-ID: <alpine.DEB.2.20.1704221844060.2351@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 22 Apr 2017, Oleg Nesterov wrote:

> Hello,
>
> I am very new to spatch and I don't even know how to formulate my question,
> let me try to explain it by example.
>
> Suppose that I want to track the usage of "+" or "-" operators, this simple
> script
>
> 	@e@
> 	expression l, r;
> 	binary operator o = { -, + };
> 	position p;
> 	@@
>
> 	l o at p r
>
> 	@script:python@
> 	l << e.l;
> 	r << e.r;
> 	p << e.p;
> 	@@
>
> 	print(p[0].line,p[0].column, ':', '(%s) %s (%s)' % (l, 'OP', r))
>
> works as expected. For example, with the following C code
>
> 	void func(void)
> 	{
> 		1 + 2 - 3;
> 		4 - 5 + 6;
> 	}
>
> I get
>
> 	3 3 : (1) OP (2)
> 	3 7 : (1 + 2) OP (3)
> 	4 3 : (4) OP (5)
> 	4 7 : (4 - 5) OP (6)
>
> Now. If I change the rule "e" above
>
> 	@e@
> 	expression l, r;
> 	position p;
> 	@@
>
> 	(
> 		l - at p r		// PAT1
> 	|
> 		l + at p r		// PAT2
> 	)
>
> I only get
>
> 	3 7 : (1 + 2) OP (3)
> 	4 3 : (4) OP (5)
>
> I could probably understand why the output for line 3 doesn't report "(1) OP (2)",
> PAT1 matches and "eats" the "1 + 2" part, so PAT2 doesn't match. Not sure.
>
> But. Could someone explain why I don't get
>
> 	4 3 : (4) OP (5)
> 	4 7 : (4 - 5) OP (6)
>
> for "4 - 5 + 6" statement at line 4? IOW, why PAT2 can not match _after_ PAT1?
>
> It looks as if only one pattern from disjunction can match in the same statement.
> IOW, (PAT1 | PAT2) actually means (PAT1* | PAT2*), not (PAT1 | PAT2)*. Say,
>
> 	1 + 2 - 3 + 4 - 5 + 6 - 7;
>
> results in
>
> 	3 7 : (1 + 2) OP (3)
> 	3 15 : (1 + 2 - 3 + 4) OP (5)
> 	3 23 : (1 + 2 - 3 + 4 - 5 + 6) OP (7)
>
> , only PAT1 matches. While in the case of
>
> 	1 - 2 + 3 - 4 + 5 - 6 + 7;
>
> PAT2 "wins" and blocks PAT2 till the end of the statement:
>
> 	3 3 : (1) OP (2)
> 	3 11 : (1 - 2 + 3) OP (4)
> 	3 19 : (1 - 2 + 3 - 4 + 5) OP (6)
>
> Is this all correct?

The idea with a disjunction is that if the first rule matches, then that
one wins.  Actually, ( A | B ) is encoded as A v (not A & B).

julia

>
> Thanks,
>
> Oleg.
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
