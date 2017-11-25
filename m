From: devel.fx.lebail@orange.fr (Francois-Xavier Le Bail)
Date: Sat, 25 Nov 2017 08:54:43 +0100
Subject: [Cocci] Question about a not made change
In-Reply-To: <alpine.DEB.2.20.1711250843550.2027@hadrien>
References: <d45758b3-f6cb-dc3a-0be2-c0b282aa9be9@orange.fr>
 <alpine.DEB.2.20.1711250843550.2027@hadrien>
Message-ID: <97896e4f-649d-8fc3-a878-00431ee1bb05@orange.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 25/11/2017 08:44, Julia Lawall wrote:
> 
> 
> On Sat, 25 Nov 2017, Francois-Xavier Le Bail wrote:
> 
>> Hi,
>>
>> I try the following patch:
>> -----
>> @@
>> u_char *p;
>> expression n;
>> @@
>> ND_PRINT(
>> ...,
>> -p[n]
>> +EXTRACT_U_1(p + n)
>>  )
>> -----
>> on the following (minimized) code:
>> -----
>> int main()
>> {
>>         u_char *p;
>>         ND_PRINT(ndo, ": %02x %02x", p[1], p[2]);
>>
>>         return 0;
>> }
>> -----
>> I got:
>> -----
>> +++ /tmp/cocci-output-1795-a34831-main.c
>> @@ -1,7 +1,7 @@
>>  int main()
>>  {
>>         u_char *p;
>> -       ND_PRINT(ndo, ": %02x %02x", p[1], p[2]);
>> +       ND_PRINT(ndo, ": %02x %02x", p[1], EXTRACT_U_1(p + 2));
>>
>>         return 0;
>>  }
>> -----
>> Why the first p[1] is not change to EXTRACT_U_1(p + 1)?
>>
>> Did I miss something obvious?
> 
> Yes :)  There is no ,... after your change, so you only perform the change
> when it is the last argument.

Of course, THANKS!

-- 
Francois-Xavier
