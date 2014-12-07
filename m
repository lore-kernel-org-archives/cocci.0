From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 07 Dec 2014 10:15:30 +0100
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <alpine.DEB.2.02.1412070749130.2044@localhost6.localdomain6>
References: <5478F848.1080808@users.sourceforge.net>
 <alpine.DEB.2.02.1412032218310.2303@localhost6.localdomain6>
 <547F8C2B.5090601@users.sourceforge.net>
 <alpine.DEB.2.02.1412032334330.2303@localhost6.localdomain6>
 <5481BF42.9040503@users.sourceforge.net>
 <alpine.DEB.2.10.1412051633240.2360@hadrien>
 <54820FEF.4080901@users.sourceforge.net>
 <54834F76.1090104@users.sourceforge.net>
 <alpine.DEB.2.10.1412061955440.2042@hadrien>
 <548358DE.6020409@users.sourceforge.net>
 <alpine.DEB.2.02.1412062139570.2256@localhost6.localdomain6>
 <548371FB.9060402@users.sourceforge.net>
 <alpine.DEB.2.02.1412062219530.2256@localhost6.localdomain6>
 <54837413.8000902@users.sourceforge.net>
 <alpine.DEB.2.02.1412062232470.2256@localhost6.localdomain6>
 <5483806D.3070805@users.sourceforge.net>
 <alpine.DEB.2.02.1412062342540.2256@localhost6.localdomain6>
 <5483902E.8060109@users.sourceforge.net>
 <alpine.DEB.2.02.1412070749130.2044@localhost6.localdomain6>
Message-ID: <54841AB2.6070609@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> I hope that a log format selection does not block a constructive dialogue
>> for the clarification of interesting SmPL rules.
> 
> Sorry but it does.

If you insist on a log file format in this way, you can also get it.
How should your preferred log format look exactly?


> I won't look at it further until there is only one SmPL file, it contains 
> a small numnber of rules,

I am going try again to inform you about software development progress in smaller steps.


> there is a small C file,

I attached one that contains the function implementations that should be found
with another semantic patch approach.


> and there is a high level description of what you expect.

I expect the following list of properties for four functions after the selection
of a single source file for a data extraction.

They fit to the filter criterium that only a single function is called within
their implementations.


>>>> static|function|"data type"|"parameter"|"source file"|line|column
>>>> 1|ast_ttm_mem_global_init|"struct drm_global_reference"|ref|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|39|1
>>>> 1|ast_ttm_mem_global_release|"struct drm_global_reference"|ref|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|45|1
>>>> 1|ast_ttm_tt_populate|"struct ttm_tt *"|ttm|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|228|12
>>>> 1|ast_ttm_tt_unpopulate|"struct ttm_tt *"|ttm|"/usr/src/linux-stable/drivers/gpu/drm/ast/ast_ttm.c"|233|13
> 
> How much of this output is actually relevant to your problem?

This the expected result in principle.


> For example, you ask me to work on a specific file.

Yes. - I find it appropriate for further tests.


> So why does the output have to contain the file name.

The file name should be copied from the source code position metavariables
to the desired list display.


> Why does the output need to contain the parameter name, etc.

The involved data type should be directly seen from the function signature.


> All that it needs is the function name and the line number,

The text column is also needed to make a found source code position unique.


> because there might be more than one function with the same name.

Yes. - Functions are also occasionally redefined because of conditional compilation.


> The rest is noise and unreadable
> - there are no space, there are lots of quotes, there sre more than 80 columns, etc.

Would you like to introduce another coding style convention?


> I can only help you with something that is matched but should not be,
> or something that is not matched but should be.

I hope that we can keep our dialogue constructive on such issue improvements.


It seems that we can eventually clarify a part of my observations (without additional
logging) already from a SmPL pattern like the following.

@single_function_call@
identifier caller, input, work;
type input_type, return_type;
@@
*return_type caller(input_type input)
 {
(
  work(input);
|
  return work(input);
)
 }

@single_function_call_with_pointer@
identifier caller, element, input, work;
type input_type, return_type;
@@
*return_type caller(input_type * input)
 {
(
  work(input->element);
|
  return work(input->element);
)
 }


elfring at Sonne:~/Projekte/Coccinelle/Probe> spatch.opt -sp-file find_single_function_call1.cocci ast_ttm-excerpt1.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: ast_ttm-excerpt1.c
diff = 
--- ast_ttm-excerpt1.c
+++ /tmp/cocci-output-19572-537bbf-ast_ttm-excerpt1.c
@@ -25,24 +25,18 @@
 /*
  * Authors: Dave Airlie <airlied@redhat.com>
  */
-static int
-ast_ttm_mem_global_init(struct drm_global_reference *ref)
 {
        return ttm_mem_global_init(ref->object);
 }
 
-static void
-ast_ttm_mem_global_release(struct drm_global_reference *ref)
 {
        ttm_mem_global_release(ref->object);
 }
 
-static int ast_ttm_tt_populate(struct ttm_tt *ttm)
 {
        return ttm_pool_populate(ttm);
 }
 
-static void ast_ttm_tt_unpopulate(struct ttm_tt *ttm)
 {
        ttm_pool_unpopulate(ttm);
 }



One of my concerns here is the influence of the function return type
on the SmPL evaluation speed so that more fine-tuning will be appropriate
for the filter patterns.

Regards,
Markus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ast_ttm-excerpt1.c
Type: text/x-csrc
Size: 1631 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20141207/6a30a4e1/attachment.bin>
