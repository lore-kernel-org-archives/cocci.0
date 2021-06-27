Return-Path: <SRS0=CCsr=LV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5ECC48BC2
	for <cocci@archiver.kernel.org>; Sun, 27 Jun 2021 08:25:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A8C619C6
	for <cocci@archiver.kernel.org>; Sun, 27 Jun 2021 08:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A8C619C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 15R8OwDx028105;
	Sun, 27 Jun 2021 10:24:58 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 80C447675;
	Sun, 27 Jun 2021 10:24:58 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6CC613783
 for <cocci@systeme.lip6.fr>; Sun, 27 Jun 2021 06:51:52 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr
 [80.12.242.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 15R4ppMh019402
 (version=TLSv1 cipher=DHE-RSA-AES128-SHA bits=128 verify=FAIL)
 for <cocci@systeme.lip6.fr>; Sun, 27 Jun 2021 06:51:51 +0200 (CEST)
Received: from [192.168.1.18] ([86.243.172.93]) by mwinf5d42 with ME
 id N4rq2500221Fzsu034rqeR; Sun, 27 Jun 2021 06:51:51 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Jun 2021 06:51:51 +0200
X-ME-IP: 86.243.172.93
To: Julia Lawall <julia.lawall@inria.fr>
Newsgroups: gmane.linux.kernel, gmane.comp.version-control.coccinelle,
 gmane.linux.kernel.janitors
References: <edc2fdb429d184d05a70956ced00845bca2d4fe9.1623871406.git.christophe.jaillet@wanadoo.fr>
 <alpine.DEB.2.22.394.2106262154280.3562@hadrien>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <65419e5b-6c82-cf5a-071a-a3421f6b846a@wanadoo.fr>
Date: Sun, 27 Jun 2021 06:51:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2106262154280.3562@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Jun 2021 10:25:00 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Jun 2021 06:51:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 27 Jun 2021 10:24:57 +0200
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Coccinelle: Update and rename
 api/alloc/pci_free_consistent.cocci
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

TGUgMjYvMDYvMjAyMSDDoCAyMTo1NSwgSnVsaWEgTGF3YWxsIGEgw6ljcml0wqA6Cj4gCj4gCj4g
T24gV2VkLCAxNiBKdW4gMjAyMSwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOgo+IAo+PiAncGNp
X2FsbG9jX2NvbnNpc3RlbnQoKScgaXMgYWJvdXQgdG8gYmUgcmVtb3ZlZCBmcm9tIHRoZSBrZXJu
ZWwuCj4+IEl0IGlzIG5vdyBtb3JlIHVzZWZ1bCB0byBjaGVjayBmb3IgZG1hX2FsbG9jX2NvaGVy
ZW50L2RtYV9mcmVlX2NvaGVyZW50Lgo+IAo+IGRtYV9hbGxvY19jb2hlcmVudCBoYXMgZm91ciBh
cmd1bWVudHMsIGFuZCBpbiB0aGUgc2NyaXB0IHRoZXJlIGFyZSBvbmx5Cj4gdGhyZWUuICBJcyB0
aGUgbnVtYmVyIG9mIGFyZ3VtZW50cyB0byBkbWFfYWxsb2NfY29oZXJlbnQgZ29pbmcgdG8gY2hh
bmdlPwoKSSBkb24ndCB0aGluayBzby4KCkp1c3QgYSBzdHVwaWQgInR5cG8iIGZyb20gbXkgc2lk
ZS4KCkNKCgo+IAo+IGp1bGlhCj4gCj4gCj4+Cj4+IFNvIGNoYW5nZSB0aGUgc2NyaXB0IGFjY29y
ZGluZ2x5IGFuZCByZW5hbWUgaXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJ
TExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+Cj4+IC0tLQo+PiBOb3Qgc3VyZSB0
aGF0IHRoZSBzY3JpcHQgd29ya3MuCj4+IFRoZXJlIGFyZSA3MTggJ2RtYV9hbGxvY19jb2hlcmVu
dCcgY2FsbHMgaW4gNS4xMy1yYzYuIEl0IGlzIHN1cnByaXNpbmcKPj4gdG8gaGF2ZSBubyBtYXRj
aCBhdCBhbGwsIG5vdCBldmVuIGEgc2luZ2xlIGZhbHNlIHBvc2l0aXZlLgo+PiAtLS0KPj4gICAu
Li5fY29uc2lzdGVudC5jb2NjaSA9PiBkbWFfZnJlZV9jb2hlcmVudC5jb2NjaX0gfCAxNiArKysr
KysrKy0tLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKPj4gICByZW5hbWUgc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUve3BjaV9mcmVlX2Nv
bnNpc3RlbnQuY29jY2kgPT4gZG1hX2ZyZWVfY29oZXJlbnQuY29jY2l9ICg1MiUpCj4+Cj4+IGRp
ZmYgLS1naXQgYS9zY3JpcHRzL2NvY2NpbmVsbGUvZnJlZS9wY2lfZnJlZV9jb25zaXN0ZW50LmNv
Y2NpIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUvZG1hX2ZyZWVfY29oZXJlbnQuY29jY2kKPj4g
c2ltaWxhcml0eSBpbmRleCA1MiUKPj4gcmVuYW1lIGZyb20gc2NyaXB0cy9jb2NjaW5lbGxlL2Zy
ZWUvcGNpX2ZyZWVfY29uc2lzdGVudC5jb2NjaQo+PiByZW5hbWUgdG8gc2NyaXB0cy9jb2NjaW5l
bGxlL2ZyZWUvZG1hX2ZyZWVfY29oZXJlbnQuY29jY2kKPj4gaW5kZXggZDUxZTkyNTU2YjQyLi43
NWYxNTllN2I2ZDcgMTAwNjQ0Cj4+IC0tLSBhL3NjcmlwdHMvY29jY2luZWxsZS9mcmVlL3BjaV9m
cmVlX2NvbnNpc3RlbnQuY29jY2kKPj4gKysrIGIvc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUvZG1h
X2ZyZWVfY29oZXJlbnQuY29jY2kKPj4gQEAgLTEsMTAgKzEsMTAgQEAKPj4gICAvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cj4+IC0vLy8gRmluZCBtaXNzaW5nIHBjaV9m
cmVlX2NvbnNpc3RlbnQgZm9yIGV2ZXJ5IHBjaV9hbGxvY19jb25zaXN0ZW50Lgo+PiArLy8vIEZp
bmQgbWlzc2luZyBkbWFfZnJlZV9jb2hlcmVudCBmb3IgZXZlcnkgZG1hX2FsbG9jX2NvaGVyZW50
Lgo+PiAgIC8vLwo+PiAgIC8vIENvbmZpZGVuY2U6IE1vZGVyYXRlCj4+ICAgLy8gQ29weXJpZ2h0
OiAoQykgMjAxMyBQZXRyIFN0cm5hZC4KPj4gICAvLyBVUkw6IGh0dHA6Ly9jb2NjaW5lbGxlLmxp
cDYuZnIvCj4+IC0vLyBLZXl3b3JkczogcGNpX2ZyZWVfY29uc2lzdGVudCwgcGNpX2FsbG9jX2Nv
bnNpc3RlbnQKPj4gKy8vIEtleXdvcmRzOiBkbWFfZnJlZV9jb2hlcmVudCwgZG1hX2FsbG9jX2Nv
aGVyZW50Cj4+ICAgLy8gT3B0aW9uczogLS1uby1pbmNsdWRlcyAtLWluY2x1ZGUtaGVhZGVycwo+
Pgo+PiAgIHZpcnR1YWwgcmVwb3J0Cj4+IEBAIC0xNywxMiArMTcsMTIgQEAgcG9zaXRpb24gcDEs
cDI7Cj4+ICAgdHlwZSBUOwo+PiAgIEBACj4+Cj4+IC1pZCA9IHBjaV9hbGxvY19jb25zaXN0ZW50
QHAxKHgseSwmeikKPj4gK2lkID0gZG1hX2FsbG9jX2NvaGVyZW50QHAxKHgseSwmeikKPj4gICAu
Li4gd2hlbiAhPSBlID0gaWQKPj4gICBpZiAoaWQgPT0gTlVMTCB8fCAuLi4pIHsgLi4uIHJldHVy
biAuLi47IH0KPj4gLS4uLiB3aGVuICE9IHBjaV9mcmVlX2NvbnNpc3RlbnQoeCx5LGlkLHopCj4+
IC0gICAgd2hlbiAhPSBpZiAoaWQpIHsgLi4uIHBjaV9mcmVlX2NvbnNpc3RlbnQoeCx5LGlkLHop
IC4uLiB9Cj4+IC0gICAgd2hlbiAhPSBpZiAoeSkgeyAuLi4gcGNpX2ZyZWVfY29uc2lzdGVudCh4
LHksaWQseikgLi4uIH0KPj4gKy4uLiB3aGVuICE9IGRtYV9mcmVlX2NvaGVyZW50KHgseSxpZCx6
KQo+PiArICAgIHdoZW4gIT0gaWYgKGlkKSB7IC4uLiBkbWFfZnJlZV9jb2hlcmVudCh4LHksaWQs
eikgLi4uIH0KPj4gKyAgICB3aGVuICE9IGlmICh5KSB7IC4uLiBkbWFfZnJlZV9jb2hlcmVudCh4
LHksaWQseikgLi4uIH0KPj4gICAgICAgd2hlbiAhPSBlID0gKFQpaWQKPj4gICAgICAgd2hlbiBl
eGlzdHMKPj4gICAoCj4+IEBAIC00MCw3ICs0MCw3IEBAIHAxIDw8IHNlYXJjaC5wMTsKPj4gICBw
MiA8PCBzZWFyY2gucDI7Cj4+ICAgQEAKPj4KPj4gLW1zZyA9ICJFUlJPUjogbWlzc2luZyBwY2lf
ZnJlZV9jb25zaXN0ZW50OyBwY2lfYWxsb2NfY29uc2lzdGVudCBvbiBsaW5lICVzIGFuZCByZXR1
cm4gd2l0aG91dCBmcmVlaW5nIG9uIGxpbmUgJXMiICUgKHAxWzBdLmxpbmUscDJbMF0ubGluZSkK
Pj4gK21zZyA9ICJFUlJPUjogbWlzc2luZyBkbWFfZnJlZV9jb2hlcmVudDsgZG1hX2FsbG9jX2Nv
aGVyZW50IG9uIGxpbmUgJXMgYW5kIHJldHVybiB3aXRob3V0IGZyZWVpbmcgb24gbGluZSAlcyIg
JSAocDFbMF0ubGluZSxwMlswXS5saW5lKQo+PiAgIGNvY2NpbGliLnJlcG9ydC5wcmludF9yZXBv
cnQocDJbMF0sbXNnKQo+Pgo+PiAgIEBzY3JpcHQ6cHl0aG9uIGRlcGVuZHMgb24gb3JnQAo+PiBA
QCAtNDgsNiArNDgsNiBAQCBwMSA8PCBzZWFyY2gucDE7Cj4+ICAgcDIgPDwgc2VhcmNoLnAyOwo+
PiAgIEBACj4+Cj4+IC1tc2cgPSAiRVJST1I6IG1pc3NpbmcgcGNpX2ZyZWVfY29uc2lzdGVudDsg
cGNpX2FsbG9jX2NvbnNpc3RlbnQgb24gbGluZSAlcyBhbmQgcmV0dXJuIHdpdGhvdXQgZnJlZWlu
ZyBvbiBsaW5lICVzIiAlIChwMVswXS5saW5lLHAyWzBdLmxpbmUpCj4+ICttc2cgPSAiRVJST1I6
IG1pc3NpbmcgZG1hX2ZyZWVfY29oZXJlbnQ7IGRtYV9hbGxvY19jb2hlcmVudCBvbiBsaW5lICVz
IGFuZCByZXR1cm4gd2l0aG91dCBmcmVlaW5nIG9uIGxpbmUgJXMiICUgKHAxWzBdLmxpbmUscDJb
MF0ubGluZSkKPj4gICBjb2NjaS5wcmludF9tYWluKG1zZyxwMSkKPj4gICBjb2NjaS5wcmludF9z
ZWNzKCIiLHAyKQo+PiAtLQo+PiAyLjMwLjIKPj4KPj4KPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
