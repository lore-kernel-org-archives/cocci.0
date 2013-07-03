From: mmarek@suse.cz (Michal Marek)
Date: Wed, 03 Jul 2013 15:26:54 +0200
Subject: [Cocci] [PATCH v3] coccicheck: span checks across CPUs
In-Reply-To: <CAAxaTiMxZV4gLmB6=hm4WBWPj6D+V-g+puU1Gm_E_Zzhm8UEWw@mail.gmail.com>
References: <20130618214929.GA15976@www.outflux.net>
 <CAAxaTiMxZV4gLmB6=hm4WBWPj6D+V-g+puU1Gm_E_Zzhm8UEWw@mail.gmail.com>
Message-ID: <51D4269E.4090204@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 18.6.2013 23:51, Nicolas Palix wrote:
> On Tue, Jun 18, 2013 at 11:49 PM, Kees Cook <keescook@chromium.org> wrote:
>> This adds parallelism by default to the "coccicheck" target using
>> spatch's "-max" and "-index" arguments.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>

Applied to kbuild.git#misc.

Michal
