From: ttabi@nvidia.com (Timur Tabi)
Date: Thu, 2 Aug 2018 15:32:11 -0500
Subject: [Cocci] Compacting parameters into fewer lines
In-Reply-To: <d7969956-e440-3dad-4d88-da39b8809148@users.sourceforge.net>
References: <CAOZdJXUFFTEQbrKMYzC_+Zf=TgzTOQZdD9NLqBRq7Pymjph9fg@mail.gmail.com>
 <2efc7722-b133-79e6-df1e-7b489213c5fd@users.sourceforge.net>
 <650a688e-b34d-4944-9484-249da36fb1c3@nvidia.com>
 <d7969956-e440-3dad-4d88-da39b8809148@users.sourceforge.net>
Message-ID: <27cf1649-2b6c-c456-ab04-70f7e211134f@nvidia.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 08/01/2018 01:08 AM, SF Markus Elfring wrote:

> Do you care if a macro (or function) parameter is optionally enclosed by parentheses?

It's not optional.  The calls to DBG_PRINTF use double parens, and need 
to be replaced with single parens when using NV_PRINTF.

>> -??????? DBG_PRINTF((DBG_MODULE_OS, DEBUGLEVEL_ERRORS,
>> -??????????? "NVRM: x86emu: int $%d (eax = %08x)\n", num, M.x86.R_EAX));
>> +??????? NV_PRINTF();
> 
> Does this test result need any further clarification for the desired
> software behaviour on an other change granularity?

I don't understand that.

The purpose of the script is to convert

DBG_PRINTF((DBG_MODULE_OS, DEBUGLEVEL_ERRORS, "NVRM: x86emu: int $%d 
(eax = %08x)\n", num, M.x86.R_EAX));

into

NV_PRINTF(LEVEL_ERRORS, "x86emu: int $%d (eax = %08x)\n", num, M.x86.R_EAX);

> How do you think about to improve the replacement specification a bit more
> by combining the variants A  till D into a single SmPL rule which will use
> a nested SmPL disjunction?

I don't know what a "nested SmPL disjunction" is.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
