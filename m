From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 11 Dec 2017 23:33:51 +0100 (CET)
Subject: [Cocci] problem with transform of expression not line-wrapping
 as expected
In-Reply-To: <804857E1F29AAC47BF68C404FC60A184D52B6AE7@ORSMSX105.amr.corp.intel.com>
References: <804857E1F29AAC47BF68C404FC60A184D52B6AE7@ORSMSX105.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1712112331300.4077@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 11 Dec 2017, Allan, Bruce W wrote:

> I'm trying to transform the following piece of code:
>
> int main(int argc, char **argv)
> {
> 	pointer_to_foo = (struct long_named_struct *)
> 		func_foo(e1, a_long_expression_e2, (long_part_a_of_exp_3 *
> 						        long_part_b_of_exp_3),
> 			    nop_expr);
> }
>
>
> with the following cocci script:
>
> @@
> expression ptr,e1,e2,e3,nop;
> type type;
> @@
> (
> - ptr = (type *)func_foo(e1,e2,e3,nop);
> + ptr = long_func_bar(macro_foobar(e1),e2,e3,SOME_OTHER_DEFINE);
> )
>
> to get:
>
> 	pointer_to_foo = long_func_bar(macro_foobar(e1), a_long_expression_e2,
> 					(long_part_a_of_exp_3 *
> 					 long_part_b_of_exp_3),
> 					SOME_OTHER_DEFINE);
>
> but instead end up with:
>
> 	pointer_to_foo = long_func_bar(macro_foobar(e1), a_long_expression_e2,
> 					(long_part_a_of_exp_3 * long_part_b_of_exp_3),
> 					SOME_OTHER_DEFINE);
>
> The problem is with the (long_part_a_of_exp_3 * long_part_b_of_exp_3) which does not line wrap as I would expect and exceeds 80-columns.  Any suggestions?

Coccinelle only contemplates putting newlines after commas.

You may get better results if you do not remove and then put back e2 and
e3, since they don't change.  Just put - and + for the things you actually
want to change.

You don't need the () in the leftmost column.  That is for a disjunction,
ie a choice between multiple possibilities, and you have only
one possibility.

julia
