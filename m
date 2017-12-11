From: bruce.w.allan@intel.com (Allan, Bruce W)
Date: Mon, 11 Dec 2017 22:27:26 +0000
Subject: [Cocci] problem with transform of expression not line-wrapping as
	expected
Message-ID: <804857E1F29AAC47BF68C404FC60A184D52B6AE7@ORSMSX105.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm trying to transform the following piece of code:

int main(int argc, char **argv)
{
	pointer_to_foo = (struct long_named_struct *)
		func_foo(e1, a_long_expression_e2, (long_part_a_of_exp_3 *
						        long_part_b_of_exp_3),
			    nop_expr);
}


with the following cocci script:

@@
expression ptr,e1,e2,e3,nop;
type type;
@@
(
- ptr = (type *)func_foo(e1,e2,e3,nop);
+ ptr = long_func_bar(macro_foobar(e1),e2,e3,SOME_OTHER_DEFINE);
)

to get:

	pointer_to_foo = long_func_bar(macro_foobar(e1), a_long_expression_e2,
					(long_part_a_of_exp_3 *
					 long_part_b_of_exp_3),
					SOME_OTHER_DEFINE);

but instead end up with:

	pointer_to_foo = long_func_bar(macro_foobar(e1), a_long_expression_e2,
					(long_part_a_of_exp_3 * long_part_b_of_exp_3),
					SOME_OTHER_DEFINE);

The problem is with the (long_part_a_of_exp_3 * long_part_b_of_exp_3) which does not line wrap as I would expect and exceeds 80-columns.  Any suggestions?

Thanks,
Bruce.
