From: devel.fx.lebail@orange.fr (Francois-Xavier Le Bail)
Date: Thu, 4 Jan 2018 15:48:03 +0100
Subject: [Cocci] Sources with high badcount
In-Reply-To: <alpine.DEB.2.20.1801041507290.3077@hadrien>
References: <6118e43b-bdba-0b6f-13a4-8caba08ec3e0@orange.fr>
 <alpine.DEB.2.20.1801041507290.3077@hadrien>
Message-ID: <f2c1b42f-791f-dd82-6824-9c83e6c3e439@orange.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 04/01/2018 15:09, Julia Lawall wrote:
> 
> 
> On Thu, 4 Jan 2018, Francois-Xavier Le Bail wrote:
> 
>> Hi,
>>
>> I got high badcounts with some sources.
> 
> Actually, in this case there are just some parse errrors in the code.
> 
> ND_PRINT((ndo, " from %s", etheraddr_string(... (line 302)
> This is missing one )
> 
> ND_PRINT((ndo, ", hops %d", EXTRACT_U_1(... (line 322)
> This has one ) too many.

Bingo !

Thank you.

Do you have an option or a tool to find these errors ?
Because neither gcc nor clang find them !
-- 
Francois-Xavier
