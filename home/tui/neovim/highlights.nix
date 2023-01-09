{
    programs.nixvim = {

        highlight = {
            Todo = {
                fg = "Blue";
                bg = "Yellow";
            };
            ExtraWhitespace.bg = "Red";
        };

        match = {
            TODO = "TODO";
            ExtraWhitespace = "\\s\\+$";
        };
    };
}
