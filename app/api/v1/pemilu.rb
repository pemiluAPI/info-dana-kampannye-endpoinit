module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :danakampanye do
      desc "Return all Dana Kampanye"
      get do
        funds = Array.new

        valid_params = {
          peserta: 'id_participant',
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]
        search = ["name LIKE :name", { name: "%#{params[:nama]}%" }]

        Fund.where(conditions)
          .where(search)
          .limit(limit)
          .offset(params[:offset])
          .each do |fund|
            funds << {
              id: fund.id,
              id_participant: fund.id_participant,
              nama_calon: fund.name,
              penerimaan: fund.revenue,
              pengeluaran_operasi: fund.operating_expenses,
              pengeluaran_modal: fund.capital_expenditures,
              pengeluaran_lain: fund.other_expenses,
              saldo: fund.balance,
              kas_rekening_khusus: fund.cash_special_account,
              kas_bendahara: fund.cash_treasurer,
              barang: fund.goods
            }
          end

        {
          results: {
            count: funds.count,
            total: Fund.where(conditions).where(search).count,
            danakampanye: funds
          }
        }
      end
    end
  end
end