From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Fri, 22 Aug 2014 23:37:16 +0200
Subject: [Cocci] Does coccinelle have the notion of signedness?
In-Reply-To: <CA+MoWDr8t3TF_rm5octP-KUT+OazG=HdfYxQNr4K-Ami4f+jEQ@mail.gmail.com>
References: <1408739891.32045.43.camel@QNXWS8653-PC>
 <CA+MoWDr8t3TF_rm5octP-KUT+OazG=HdfYxQNr4K-Ami4f+jEQ@mail.gmail.com>
Message-ID: <CA+MoWDrQ-qD50=WUyKBEMyhiO=b+MtteXPht7==Y42wJuuCz4A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Gmail has changed the text format. There is a tab before
cocci.include_match(False)

On Fri, Aug 22, 2014 at 11:28 PM, Peter Senna Tschudin
<peter.senna@gmail.com> wrote:
> I would try:
> @r@
> type T;
> identifier i;
> @@
> T i;
>
> @script:python@
> T << r.T;
> @@
> if "unsigned" not in T:
> cocci.include_match(False)
>
> @printer@
> type r.T;
> identifier r.i;
> @@
> * T i;
>
> On Fri, Aug 22, 2014 at 10:38 PM, Mitchell Cuddie <mcuddie@qnx.com> wrote:
>> Julia,
>>
>> I would like to declare a metatype T, where T is restricted to the set
>> of unsigned types.
>>
>> (i.e. unsigned long, unsigned int, but not int or long)
>>
>> cheers,
>>
>> Mitchell
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>
>
>
> --
> Peter



-- 
Peter
