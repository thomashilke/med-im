function [ word ] = randWord( len )
    alphabet = char('a':'z');
    word = alphabet(randi(26, 1, len ));
end

