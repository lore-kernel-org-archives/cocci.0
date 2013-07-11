From: wagi@monom.org (Daniel Wagner)
Date: Thu, 11 Jul 2013 11:07:11 +0200
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <alpine.DEB.2.02.1307111026390.2253@hadrien>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien>
Message-ID: <51DE75BF.3060207@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 07/11/2013 10:29 AM, Julia Lawall wrote:
>> I'd like to convert a bunch of gboolean decleration to stdbool in our ConnMan
>> code base. I am a noob with coccinelle. I have partial success so far but I do
>> not thing I am doing the right thing. So any advice is welcome :)
>>
>>
>> This here is my current coccinelle script for converting gboolean used as
>> stack variable. I have also one for structs, which gave my good results.
>> Another one is needed then for the function arguments. But let's first have a
>> look on this part.
>>
>> @r1@
>> position p;
>> typedef gboolean;
>> identifier func,x;
>> @@
>> func(...) {
>> <...
>> 	gboolean at p x;
>> ...>
>> }
>>
>> @r2@
>> position r1.p;
>> typedef bool;
>> @@
>> - gboolean at p
>> + bool
>>
>> @r3@
>> identifier r1.x;
>> @@
>> (
>> - x = FALSE
>> + x = false
>> |
>> - x = TRUE
>> + x = true
>> )
>>
>> int main(int argc, char *argv[])
>> {
>> 	gboolean b = TRUE;
>>
>> 	return 0;
>> }
>>
>> results in
>>
>> int main(int argc, char *argv[])
>> {
>> -       gboolean b = TRUE;
>> +       bool b = true;
>>
>>          return 0;
>> }
>>
>> which is what I wanted. Now the problem is that I really have no clue to mach
>> on things like
>>
>> int main(int argc, char *argv[])
>> {
>> 	gboolean b = TRUE, c = FALSE;
>>
>> 	return 0;
>> }
>>
>> Any idea?
>
> Did you try just
>
> @@
> @@
>
> - gboolean
> + bool
>
> Also, for yoru TRUE -> true rule, you could consider

Yes, the problem is that I can't replace all gbooleans because we are 
GLib, e.g. we are using quite a few timers


guint g_timeout_add (guint interval, GSourceFunc function,
			 gpointer data);

gboolean (*GSourceFunc) (gpointer user_data);

https://developer.gnome.org/glib/2.36/glib-The-Main-Event-Loop.html#g-timeout-add

So these gboolean should not be changed. BTW, when I tried your probosal 
it would not change this here

	gboolean b,c;

changing the rules to

	- gboolean
	++ bool

resulted int

	bool bool b,c;

Also not what I wanted :)

Anyway, the main problem I think is that I do not want to change all 
gboolean, only the ones in structs and the ones declared on the stack. 
Maybe a few in fucntion signatures but that I can do by hand. I just 
dont want to change 1000 lines by hand, that is far to dangerous :)

> @@
> gboolean x;
> @@
>
> x =
> - TRUE
> + true
>
> That is, you don't have to find the type declaration and then the
> identifier.  You can describe the type of an arbitrary expression x.

Ah okay. I wanted to make sure I only change those assignments which did 
change.

cheers,
daniel
