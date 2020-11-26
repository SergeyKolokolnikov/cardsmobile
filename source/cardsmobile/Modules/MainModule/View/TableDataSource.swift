
import UIKit

class TableDataSource: GenericDataSource<Card>, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! UITableViewCell

        let currencyRate = self.data.value[indexPath.row]
        //cell.currencyRate = currencyRate

        return cell
    }
}
