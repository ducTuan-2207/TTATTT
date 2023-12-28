import UIKit

class MaHoaHangViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var chuoi: UITextField!
    @IBOutlet weak var ketQua: UILabel!

    @IBOutlet weak var khoa: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        chuoi.delegate = self
        khoa.delegate = self
    }

    @IBAction func key(_ sender: Any) {
    }
    @IBAction func maHoa(_ sender: Any) {
        guard let chuoiText = chuoi.text, !chuoiText.isEmpty,
              let khoaText = khoa.text, !khoaText.isEmpty else {
            // Xử lý khi đầu vào không hợp lệ
            ketQua.text = "Dữ liệu không hợp lệ"
            return
        }
        let ketQuaText = maHoa(chuoi: chuoiText, khoa: khoaText)
        ketQua.text = "Mã hóa: \(ketQuaText)"
    }

    @IBAction func giaiMa(_ sender: Any) {
        guard let chuoiMaHoa = chuoi.text, !chuoiMaHoa.isEmpty,
              let khoaText = khoa.text, !khoaText.isEmpty else {
            // Xử lý khi đầu vào không hợp lệ
            ketQua.text = "Dữ liệu không hợp lệ"
            return
        }
        let ketQuaGiaiMa = giaiMa(chuoiMaHoa: chuoiMaHoa, khoa: khoaText)
        ketQua.text = "Giải mã: \(ketQuaGiaiMa)"
    }

    func maHoa(chuoi: String, khoa: String) -> String {
        // Thực hiện mã hóa ở đây
        // Đảm bảo mã hóa và giải mã cùng sử dụng cùng một cách mã hóa
        var ketQua = ""
        let khoaUTF8 = Array(khoa.utf8)

        for (i, kyTu) in chuoi.enumerated() {
            let maKyTu = kyTu.asciiValue!
            let byteKhoa = khoaUTF8[i % khoaUTF8.count]
            let kyTuMaHoa = maKyTu ^ byteKhoa
            ketQua.append(Character(UnicodeScalar(kyTuMaHoa)))
        }

        return ketQua
    }

    func giaiMa(chuoiMaHoa: String, khoa: String) -> String {
        // Thực hiện giải mã ở đây
        // Đảm bảo mã hóa và giải mã cùng sử dụng cùng một cách mã hóa
        var ketQuaGiaiMa = ""
        let khoaUTF8 = Array(khoa.utf8)

        for (i, kyTuMaHoa) in chuoiMaHoa.enumerated() {
            let maKyTuMaHoa = kyTuMaHoa.asciiValue!
            let byteKhoa = khoaUTF8[i % khoaUTF8.count]
            let kyTuGiaiMa = maKyTuMaHoa ^ byteKhoa
            ketQuaGiaiMa.append(Character(UnicodeScalar(kyTuGiaiMa)))
        }

        return ketQuaGiaiMa
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Ẩn bàn phím khi người dùng nhấn Return trên bàn phím
        textField.resignFirstResponder()
        return true
    }
}
