﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VIEW_USECASE
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new GDChinhGiaoVien());
            /// code của Chiều Chiều
            //Application.Run(new GDChinhGiaoVu());
            //Application.Run(new FrmLOGIN());
            Application.Run(new FrmGiaoVu());
        }
    }
}
