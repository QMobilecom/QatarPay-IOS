//
//  Views.swift
//  QPay
//
//  Created by Dev. Mohmd on 7/3/20.
//  Copyright © 2020 Dev. Mohmd. All rights reserved.
//

import Foundation
import UIKit

enum Images: String {
    
    // Project Images...
    /// Project Image
    case ic_naps_checkout                  = "ic_naps_checkout",
         ic_credit_card_payment_method     = "ic_credit_card_payment_method",
         ic_ooredoo_money_payment_method   = "ic_ooredoo_money_payment_method",
         ic_ooredoo_payment_method         = "ic_ooredoo_payment_method",
         ic_paypal_payment_method          = "ic_paypal_payment_method",
         ic_vodafone_checkout              = "ic_vodafone_checkout",
         ic_arrow_right_kahramaa           = "ic_arrow_right_kahramaa",
         ic_error_circle                   = "ic_error_circle",
         ic_email_white_send_invoice       = "ic_email_white_send_invoice",
         ic_email_red_send_invoice         = "ic_email_red_send_invoice",
         ic_link_white_send_invoice        = "ic_link_white_send_invoice",
         ic_link_red_send_invoice          = "ic_link_red_send_invoice",
         ic_money_invoices                 = "ic_money_invoices",
         ic_sand_clock_invoices            = "ic_sand_clock_invoices",
         ic_error_circle_invoices          = "ic_error_circle_invoices",
         ic_contact_home                   = "ic_contact_home",
         ic_logout_home                    = "ic_logout_home",
         ic_gear                           = "ic_gear",
         ic_empty_tab_my_library           = "ic_empty_tab_my_library",
         ic_cards_tab_my_library           = "ic_cards_tab_my_library",
         ic_bank_tab_my_library            = "ic_bank_tab_my_library",
         ic_documents_tab_my_library       = "ic_documents_tab_my_library",
         ic_id_license_tab_my_library      = "ic_id_license_tab_my_library",
         ic_passport_tab_my_library        = "ic_passport_tab_my_library",
         credit_card_container_my_library  = "credit_card_container_my_library",
         debit_card_container_my_library   = "debit_card_container_my_library",
         loyalty_card_container_my_library = "loyalty_card_container_my_library",
         bank_container_my_library         = "bank_container_my_library",
         documents_container_my_library    = "documents_container_my_library",
         id_container_my_library           = "id_container_my_library",
         driving_container_my_library      = "driving_container_my_library",
         passport_container_my_library     = "passport_container_my_library",
         ic_visa_card_details              = "ic_visa_card_details",
         ic_visa_logo_card                 = "ic_visa_logo_card",
         ic_mastercard_card_details        = "ic_mastercard_card_details",
         ic_unknown_card_details           = "ic_unknown_card_details",
         ic_avatar                         = "ic_avatar",
         ic_transaction_person             = "ic_transaction_person",
         ic_maroon_card_home               = "ic_maroon_card_home",
         ic_blue_card_home                 = "ic_blue_card_home",
         ic_black_card_home                = "ic_black_card_home",
         ic_mastercard_my_library          = "ic_mastercard_my_library",
         ic_diners_club_my_library         = "ic_diners_club_my_library",
         ic_maestro_my_library             = "ic_maestro_my_library",
         ic_scan_qr_code                   = "ic_scan_qr_code",
         ic_vendex_qrcode                  = "ic_vendex_qrcode",
         ic_topup_money_transfer           = "ic_topup_money_transfer",
         ic_transfer_money_transfer        = "ic_transfer_money_transfer",
         ic_request_money_transfer         = "ic_request_money_transfer",
         ic_arrow_money_transfer           = "ic_arrow_money_transfer",
         bg_analytics_red                  = "bg_analytics_red",
         bg_analytics_blue                 = "bg_analytics_blue",
         ic_arrow_down_transfer            = "ic_arrow_down_transfer",
         ic_arrow_right_transfer           = "ic_arrow_right_transfer",
         ic_arrow_down_gray                = "ic_arrow_down_gray",
         ic_search_my_shops                = "ic_search_my_shops",
         ic_arrow_up_my_book_product       = "ic_arrow_up_my_book_product",
         ic_arrow_down_my_book_product     = "ic_arrow_down_my_book_product",
         bg_btn_qmobile                    = "bg_btn_qmobile",
         ic_person_settings                = "ic_person_settings",
         ic_address_settings               = "ic_address_settings",
         ic_lock_settings                  = "ic_lock_settings",
         ic_invite_settings                = "ic_invite_settings",
         ic_contact_us_settings            = "ic_contact_us_settings",
         ic_logout_settings                = "ic_logout_settings",
         ic_edit_personal_info             = "ic_edit_personal_info",
         ic_verified_personal_info         = "ic_verified_personal_info",
         ic_unverified_personal_info       = "ic_unverified_personal_info",
         ic_eye_personal_info              = "ic_eye_personal_info",
         ic_reset_personal_info            = "ic_reset_personal_info",
         ic_metro_rail_card                = "ic_metro_rail_card",
         ic_karwa_card                     = "ic_karwa_card",
         ic_cv_skills                      = "ic_cv_skills",
         bg_cv_skills                      = "bg_cv_skills",
         ic_cv_personal_information        = "ic_cv_personal_information",
         bg_cv_personal_information        = "bg_cv_personal_information",
         ic_cv_expertise                   = "ic_cv_expertise",
         bg_cv_expertise                   = "bg_cv_expertise",
         ic_avatar_photo                   = "ic_avatar_photo",
         ic_cv_job                         = "ic_cv_job",
         ic_cv_lock_red                    = "ic_cv_lock_red",
         ic_cv_lock                        = "ic_cv_lock",
         job_hunt_profile_image            = "profile_photo",
         company_logo_image                = "company_logo",
         ic_save_limousine                 = "ic_save_limousine",
         bg_limousine_navigation           = "bg_limousine_navigation",
         bg_limousine_tab                  = "bg_limousine_tab",
         bg_limousine_qatar                = "bg_limousine_qatar",
         bg_child_Care_navigation          = "bg_child_Care_navigation",
         bg_child_Care_tab                 = "bg_child_Care_tab",
         bg_hotel_navigation               = "bg_hotel_navigation",
         bg_hotel_tab                      = "bg_hotel_tab",
         bg_hotel_qatar                    = "bg_hotel_qatar",
         bg_dine_navigation                = "bg_dine_navigation",
         bg_dine_qater                     = "bg_dine_qater",
         bg_dine_tab                       = "bg_dine_tabs",
         bg_insurance_navigation           = "bg_insurance_navigation",
         bg_insurance_qater                = "bg_insurance_qater",
         bg_insurance_tab                  = "bg_insurance_tab",
         bg_medical_center_tab             = "bg_medical_center_tab",
         bg_medical_center_navigation      = "bg_medical_center_navigation",
         bg_medical_center_qatar           = "bg_medical_center_qatar",
         bg_qater_school_navigation        = "bg_qater_school_navigation",
         bg_school_qater                   = "bg_school_qater",
         bg_qater_School_tab               = "bg_qater_School_tab",
         stock_history                     = "stock_history",
         stock_index                       = "stock_index",
         stock_market                      = "stock_market",
         stock_mystocks                    = "stock_mystocks",
         stock_news                        = "stock_news",
         credit_inactive                   = "credit_inactive",
         qatar_avatar_ic                   = "qatar_avatar_ic",
         bg_add_phone_bills                = "bg_add_phone_bills",
         bg_add_kahramaa_bills             = "bg_add_kahramaa_bills",
         bg_qatar_cool                     = "bg_qatar_cool"
    
    
    // System Images...
    
    /// System Image
    case eye = "eye",
         eye_slash = "eye.slash",
         info_circle_fill = "info.circle.fill",
         trash = "trash"
    
    var image: UIImage {
        let projectImage = UIImage(named: self.rawValue)
        let systemImage = UIImage(systemName: self.rawValue)
        
        if let image = projectImage {
            return image
        }else if let image = systemImage {
            return image
        }
        return UIImage()
    }
}
