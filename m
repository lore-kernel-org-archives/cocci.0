From: kumar.gala@linaro.org (Kumar Gala)
Date: Tue, 14 Feb 2017 08:59:33 -0500
Subject: [Cocci] Bitfield info?
In-Reply-To: <alpine.DEB.2.20.1702132227530.2032@hadrien>
References: <1B4D9683-DB44-4445-8873-B7D29FC44F7B@linaro.org>
 <CA+MoWDoXAEwqyhZzicB3dk4R5gghnwfXTcOmFfF3kYA9svmNug@mail.gmail.com>
 <682B6748-18A2-40EA-90D8-EB02B754B6C7@linaro.org>
 <alpine.DEB.2.20.1702132203030.2032@hadrien>
 <alpine.DEB.2.20.1702132227530.2032@hadrien>
Message-ID: <DBEE99BA-C053-489E-8088-25A680684297@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Feb 13, 2017, at 4:28 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Mon, 13 Feb 2017, Julia Lawall wrote:
> 
>> It's not supported in the semantic patch language.
>> 
>> One possible hack is to do something like the following:
>> 
>> @initialize:ocaml@
>> @@
>> 
>> let isfield i =
>>    List.length (Str.split (Str.regexp ":") i) = 2
>> 
>> @r@
>> identifier foo;
>> field i : script:ocaml() { isfield(i) };
>> type T;
>> @@
>> 
>> struct foo { ... i ... };
>> 
>> @script:ocaml@
>> i << r.i;
>> @@
>> 
>> Printf.printf "%s\n" i
> 
> The above code should now work in the github version of Coccinelle.
> 
> julia
> 
> 
>> The ocaml code just checks that the string representing the field
>> declaration contains a :
>> 
>> This is not working right at the moment.  It seems to be related
>> to a problem that I was already working on today, so I will let you know
>> when it is functioning on github.

Thanks.

Is there a way I can go from the printf variable back to its type info?

Trying to see how I can merge the script I sent with the one you?ve posted.

- k
