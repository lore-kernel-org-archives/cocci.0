From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Thu, 30 Jun 2016 08:13:28 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to replace NULL test with
 IS_ERR test for devm_ioremap_resource
In-Reply-To: <20160629192357.GA9260@tetsubishi>
References: <20160629183347.GA17067@amitoj-Inspiron-3542>
 <20160629192357.GA9260@tetsubishi>
Message-ID: <CA+5yK5GBcm3TFdU_vAFDsob2CqsUuVwaZEQEL-8bc4pEGoP12Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jun 30, 2016 at 12:53 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Jun 30, 2016 at 12:03:47AM +0530, Amitoj Kaur Chawla wrote:
>> This script detects cases which have incorrect error handling for
>> devm_ioremap_resource function, employing a NULL test instead of an
>> IS_ERR() test.
>>
>> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
>
> Why don't we fix the code at the same time?
>

Thank you for your suggestion. I will fix this up and resend.

> And it should not be restricted to devm_ioremap_resource() but
> extensible so other functions could be added later?
>
> (Surprised to see that we don't have such a script yet)
>

I am working on a more general solution, extending to other functions.

Amitoj
