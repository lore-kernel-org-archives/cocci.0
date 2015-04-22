From: d.granat@samsung.com (Daniel Granat)
Date: Wed, 22 Apr 2015 13:16:54 +0200
Subject: [Cocci] [PATCH] Add coccinelle script that makes sure that
 tables are NULL terminated
In-Reply-To: <55378124.2060908@gmail.com>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
 <55378124.2060908@gmail.com>
Message-ID: <55378326.4030707@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Ok, but I'm going to improve the script. New coccinelle release give my 
opportunity to simplify this a lot, so I'll send next version of my 
patch soon.

Best regards,
--
Daniel Granat
Junior Software Engineer
Samsung R&D Institute Poland (SRPOL)
Al. Armii Ludowej 14, 00-638 Warszawa, Poland

On 04/22/2015 01:08 PM, Krzysztof Kozlowski wrote:
> W dniu 27.02.2015 o 22:21, Daniel Granat pisze:
>> Signed-off-by: Daniel Granat <d.granat@samsung.com>
>> ---
>>    scripts/coccinelle/misc/device_id_tables.cocci | 95 ++++++++++++++++++++++++++
>>    1 file changed, 95 insertions(+)
>>    create mode 100644 scripts/coccinelle/misc/device_id_tables.cocci
>
> I like the idea and I think it is useful.
> Tested-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>
> However applying the patch gave some warnings:
>
> Applying: Add coccinelle script that makes sure that tables are NULL terminated
> /home/dev/linux/linux/.git/rebase-apply/patch:64: space before tab in indent.
>          	coccilib.report.print_report(p1[0],msg)
> /home/dev/linux/linux/.git/rebase-apply/patch:89: trailing whitespace.
> struct matched_name arr[] = {
> /home/dev/linux/linux/.git/rebase-apply/patch:99: trailing whitespace.
> struct matched_name arr[] = {
> /home/dev/linux/linux/.git/rebase-apply/patch:106: new blank line at EOF.
> +
> warning: 4 lines add whitespace errors.
>
> Best regards,
> Krzysztof
>
