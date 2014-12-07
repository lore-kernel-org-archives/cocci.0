From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 07 Dec 2014 11:22:43 +0100
Subject: [Cocci] Finding function implementations that call only a
 single function.
In-Reply-To: <alpine.DEB.2.02.1412071027040.2044@localhost6.localdomain6>
References: <5478F848.1080808@users.sourceforge.net>
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
 <54841AB2.6070609@users.sourceforge.net>
 <alpine.DEB.2.02.1412071027040.2044@localhost6.localdomain6>
Message-ID: <54842A73.4000203@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> OK, now the C file is manageable, if I drop the 20 lines of comments at 
> the top of the file.
> 
> The following is also a completely understandable semantic patch:
> 
>> @single_function_call@
>> identifier caller, input, work;
>> type input_type, return_type;
>> @@
>> *return_type caller(input_type input)
>>  {
>> (
>>   work(input);
>> |
>>   return work(input);
>> )
>>  }
>>
>> @single_function_call_with_pointer@
>> identifier caller, element, input, work;
>> type input_type, return_type;
>> @@
>> *return_type caller(input_type * input)
>>  {
>> (
>>   work(input->element);
>> |
>>   return work(input->element);
>> )
>>  }
> 
> So, now what is the problem with the following output?

The source code output is not the problem from the application
of such a small SmPL script.

I find that my filter patterns contain open issues here.

One part of each SmPL disjunction will always not match in this approach
if an analysed function implementation has got the return type "void".
Would the specification of a metavariable "return_type" be also
unnecessary and inappropriate in this use case?


>> One of my concerns here is the influence of the function return type
>> on the SmPL evaluation speed so that more fine-tuning will be appropriate
>> for the filter patterns.
> 
> Worrying about the speed of matching of a couple of tokens is completely pointless.

I guess that this view will need adjustments if I am going to rerun
an extended version of the shown SmPL example on all Linux source files
as it happened for a couple of clean-ups around unnecessary (pointer) checks.


> If you want to see that in practice, just use the --profile 
> option and see what is the time with and without the matching you are 
> concerned about.

I might try that out more in the near future.


> Unless your pattern requires following a lot of different control-flow paths,
> eg due to sequences of conditionals, the C code parsing time will massively
> dominate the matching time.

The Coccinelle software has got difficulties with specific Linux source files
so that it became safer to add the command line parameter "timeout" for example.

I can only directly influence the SmPL scripts here. So I try to make them as good
and fast as I can. Other technical improvements will eventually need more efforts.

Regards,
Markus
