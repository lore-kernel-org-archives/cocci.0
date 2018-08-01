From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 1 Aug 2018 08:08:45 +0200
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <650a688e-b34d-4944-9484-249da36fb1c3@nvidia.com>
References: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
 <2efc7722-b133-79e6-df1e-7b489213c5fd@users.sourceforge.net>
 <650a688e-b34d-4944-9484-249da36fb1c3@nvidia.com>
Message-ID: <d7969956-e440-3dad-4d88-da39b8809148@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @rule1@
>> expression x;
>> expression list y;
>> @@
>> -DBG_PRINTF
>> +NV_PRINTF
>> ?????????? (
>> -????????? (x),
>> ??????????? y);
> 
> This doesn't work:

Do you care if a macro (or function) parameter is optionally enclosed by parentheses?


> -??????? DBG_PRINTF((DBG_MODULE_OS, DEBUGLEVEL_ERRORS,
> -??????????? "NVRM: x86emu: int $%d (eax = %08x)\n", num, M.x86.R_EAX));
> +??????? NV_PRINTF();

Does this test result need any further clarification for the desired
software behaviour on an other change granularity?


> I always appreciate optimization suggestions.

I have got another software development idea for this transformation approach.

How do you think about to improve the replacement specification a bit more
by combining the variants A  till D into a single SmPL rule which will use
a nested SmPL disjunction?

Regards,
Markus
